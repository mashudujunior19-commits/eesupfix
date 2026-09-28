// Proxies Google Places Autocomplete + Geocoding calls server-side.
//
// The Flutter web build cannot call maps.googleapis.com directly: Google's
// Places/Geocoding REST APIs don't send CORS headers, so browser fetches to
// them fail. Native (Android/iOS) builds aren't subject to CORS and keep
// calling Google directly. This function exists only for the web code path.
const GOOGLE_API_KEY = Deno.env.get("GOOGLE_API_KEY");

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

interface GeocodeResult {
  address: string;
  lat: number;
  lng: number;
}

async function geocodeByPlaceId(placeId: string): Promise<GeocodeResult | null> {
  const params = new URLSearchParams({ place_id: placeId, key: GOOGLE_API_KEY! });
  const res = await fetch(
    `https://maps.googleapis.com/maps/api/geocode/json?${params}`,
  );
  const body = await res.json();
  const result = body.results?.[0];
  if (!result) return null;
  return {
    address: result.formatted_address as string,
    lat: result.geometry.location.lat as number,
    lng: result.geometry.location.lng as number,
  };
}

async function autocomplete(input: string, region?: string) {
  const params = new URLSearchParams({ input, key: GOOGLE_API_KEY! });
  if (region) params.set("region", region);

  const res = await fetch(
    `https://maps.googleapis.com/maps/api/place/autocomplete/json?${params}`,
  );
  const body = await res.json();
  const predictions = (body.predictions ?? []) as Array<
    { place_id: string }
  >;

  const places = await Promise.all(
    predictions.map(async (prediction) => {
      const detail = await geocodeByPlaceId(prediction.place_id);
      if (!detail) return null;
      return {
        address: detail.address,
        placeId: prediction.place_id,
        lat: detail.lat,
        lng: detail.lng,
      };
    }),
  );

  return places.filter((place) => place !== null);
}

async function geocode(address: string) {
  const params = new URLSearchParams({ address, key: GOOGLE_API_KEY! });
  const res = await fetch(
    `https://maps.googleapis.com/maps/api/geocode/json?${params}`,
  );
  const body = await res.json();
  const result = body.results?.[0];
  if (!result) return null;
  return {
    lat: result.geometry.location.lat as number,
    lng: result.geometry.location.lng as number,
  };
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  if (!GOOGLE_API_KEY) {
    return json({ error: "GOOGLE_API_KEY is not configured" }, 500);
  }

  try {
    const { action, input, region, address } = await req.json();

    if (action === "autocomplete") {
      if (!input) return json({ error: "input is required" }, 400);
      return json(await autocomplete(input, region));
    }

    if (action === "geocode") {
      if (!address) return json({ error: "address is required" }, 400);
      return json(await geocode(address));
    }

    return json({ error: `Unknown action: ${action}` }, 400);
  } catch (e) {
    return json({ error: e instanceof Error ? e.message : String(e) }, 500);
  }
});
