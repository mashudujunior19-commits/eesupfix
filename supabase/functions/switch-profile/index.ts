// Switch Profile: moves the app between a person's own account and their
// business account (see migrations/20261118140000_business_accounts.sql).
//
// POST { "to": "business" }   called by the person (owner)
// POST { "to": "individual" } called by the business account
// POST { "to": "prepare" }    creates the business account ahead of time
//
// The answer is a one-time sign-in token for the other account
// ({ token_hash }), which the app exchanges with verifyOTP(type: magiclink).
// When the owner has no email address (phone sign-in), going back answers
// { restore: true } and the app restores the session it kept on the device.
//
// The business account has no password and is never signed into any other
// way: only its owner, signed in, can get a token for it.
import { createClient } from "jsr:@supabase/supabase-js@2";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function reply(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...cors, "Content-Type": "application/json" },
  });
}

const admin = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  { auth: { persistSession: false, autoRefreshToken: false } },
);

/** A one-time sign-in token for [email] (nothing is sent by email). */
async function tokenFor(email: string) {
  const { data, error } = await admin.auth.admin.generateLink({
    type: "magiclink",
    email,
  });
  if (error || !data?.properties?.hashed_token) {
    throw new Error(error?.message ?? "Could not prepare the sign-in.");
  }
  return { token_hash: data.properties.hashed_token, user_id: data.user?.id };
}

/** The business account's sign-in address: internal, never emailed. */
function businessEmail(ownerId: string) {
  return `business-${ownerId}@accounts.towris.invalid`;
}

/**
 * Creates the business account for [ownerId] the first time (auth user, then
 * its profile, wallets, address, ...) and returns its sign-in address.
 */
async function ensureBusinessAccount(ownerId: string): Promise<string> {
  const email = businessEmail(ownerId);
  const { data: existing } = await admin
    .from("business_account")
    .select("business_user_id")
    .eq("owner_user_id", ownerId)
    .maybeSingle();
  if (existing) return email;

  const created = await admin.auth.admin.createUser({
    email,
    email_confirm: true,
    app_metadata: { business_of: ownerId },
  });
  let businessUserId = created.data?.user?.id;
  if (created.error) {
    // A retry after a half-finished first attempt: the user is already there.
    if (!/already|registered|exists/i.test(created.error.message)) throw created.error;
    businessUserId = (await tokenFor(email)).user_id;
  }
  const { error } = await admin.rpc("provision_business_account", {
    _owner: ownerId,
    _business_user_id: businessUserId,
  });
  if (error) throw error;
  return email;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return reply({ error: "Use POST." }, 405);

  const jwt = (req.headers.get("Authorization") ?? "").replace(/^Bearer\s+/i, "");
  const { data: who, error: whoError } = await admin.auth.getUser(jwt);
  const caller = who?.user;
  if (whoError || !caller) return reply({ error: "Please sign in again." }, 401);

  let to = "";
  try {
    to = String((await req.json())?.to ?? "").toLowerCase();
  } catch (_) {
    // handled below
  }

  try {
    // Is the caller a business account? Then this is its owner.
    const { data: link } = await admin
      .from("business_account")
      .select("owner_user_id")
      .eq("business_user_id", caller.id)
      .maybeSingle();
    const ownerId: string | null = link?.owner_user_id ?? null;

    if (to === "business" || to === "prepare") {
      if (ownerId) {
        if (to === "prepare") return reply({ ok: true });
        return reply({ error: "You are already using your business profile." }, 409);
      }

      const { data: approved, error: approvedError } = await admin.rpc(
        "has_approved_business_profile",
        { _user_id: caller.id },
      );
      if (approvedError) throw approvedError;
      if (!approved) {
        return reply({
          error: "Your business profile is available once your Get Involved application is approved.",
        }, 403);
      }

      const email = await ensureBusinessAccount(caller.id);
      // "prepare": the app calls this when the menu opens, so the first real
      // switch does not wait for the account to be created.
      if (to === "prepare") return reply({ ok: true });

      const token = await tokenFor(email);
      return reply({ token_hash: token.token_hash });
    }

    if (to === "individual") {
      if (!ownerId) return reply({ error: "You are already using your individual profile." }, 409);
      const { data: owner, error: ownerError } = await admin.auth.admin.getUserById(ownerId);
      if (ownerError || !owner?.user) throw ownerError ?? new Error("Owner not found.");
      if (!owner.user.email) return reply({ restore: true });
      const token = await tokenFor(owner.user.email);
      return reply({ token_hash: token.token_hash });
    }

    return reply({ error: "Choose the business or the individual profile." }, 422);
  } catch (e) {
    console.error("switch-profile", e);
    const message = e instanceof Error ? e.message : String((e as { message?: string })?.message ?? e);
    return reply({ error: message || "Could not switch profiles." }, 500);
  }
});
