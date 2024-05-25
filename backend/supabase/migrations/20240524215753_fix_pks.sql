
ALTER TABLE ONLY "finances"."online_payment"
    ADD CONSTRAINT "online_payment_pkey" PRIMARY KEY ("payment_id");

ALTER TABLE ONLY "finances"."online_payment"
    ADD CONSTRAINT "online_payment_secondary_id_key" UNIQUE ("secondary_id");

ALTER TABLE ONLY "finances"."payment_gateway"
    ADD CONSTRAINT "payment_gateway_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "finances"."payout_request"
    ADD CONSTRAINT "payout_request_pkey" PRIMARY KEY ("id");


ALTER TABLE ONLY "finances"."online_payment"
    ADD CONSTRAINT "finances_online_payment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profile"("user_id") ON DELETE CASCADE;




CREATE POLICY "Enable access for authenticated users only" ON "finances"."online_payment" TO "authenticated" USING (true) WITH CHECK (true);

CREATE POLICY "Enable access for authenticated users only" ON "finances"."payment_gateway" TO "authenticated" USING (true) WITH CHECK (true);


