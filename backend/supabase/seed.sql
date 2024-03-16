-- INSERT INTO auth.users ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at",
-- "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new",
-- "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at",
-- "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current",
-- "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at") VALUES
-- ('00000000-0000-0000-0000-000000000000','36c994a1-f913-4ca2-a4cf-fd249f419f15', 'authenticated','authenticated',
-- 'engage@eesup.com', '$2a$10$GJIwaY7V65.xFTPSpcccQ.l3mMkH8E8A1a/QUp4bRkTNoIAN7GW/S','2023-07-24 19:31:54.442346+00', null, '', null, '', null, null, null, null,
-- '2023-07-24 19:31:54.442346+00', '{"provider":"email","providers":["email"]}',
-- '{"type":"Corporate","is_corp":true,"npc_reg":null,"corp_reg":null,"corp_name":"EESUp engage","referral_code":null,"is_phone_sign_up":true}', null,
-- '2023-07-24 19:31:54.442346+00', '2023-07-24 19:31:54.442346+00', null, '', '',
-- '', null, '', 0, null, '', null, false, null);



-- INSERT INTO "profile" ("user_id", "rsa_id_number", "first_name", "last_name", "email", "phone", "is_active", "deactivated_on", "accepted_ts_and_cs", "role", "corp_name", "npc_reg", "corp_reg", "corp_address_id", "corp_vat_no", "is_approved", "referral_code", "class") 
-- VALUES ('36c994a1-f913-4ca2-a4cf-fd249f419f15', null, null, null, 'engage@eesup.com', null, true, null, true, 'Corporate', 'EESUp engage', null, null, null, null, true, 10775, null);

-- INSERT INTO "geolocations"."target_area" ("id", "name", "center_latitude", "center_longitude", "area_radius", "center_full_address", "is_active")
--     VALUES
-- 	('1', 'Atteridgeville', '-25.773730988588355', '28.068766098640975', '3.9870469911880315', 'Atteridgeville', 'true'),
-- 	('2', 'Glen Austin 1', '-25.979893', '28.148103', '3.5', '34 Pitzer Road', 'true'),
-- 	('3', 'Ivory Park', '-25.9982468', '28.1937908', '2.5', 'Jambala St', 'true'),
-- 	('4', 'Riverside View', '-25.96090969110766', '28.002017352436365', '1.5', 'cnr Porcupine and Lenner', 'true'),
-- 	('5', 'Clayville', '-25.95035198663186', '28.220487629742408', '2', '53 Reginald St', 'true'),
-- 	('6', 'Blue Valley Golf Estate', '-25.9355452', '28.1180136', '1.4', 'Montrose Street', 'true'),
-- 	('7', 'Celtisdal', '-25.8703256', '28.1292498', '2.5', '249 Louisa Park', 'true'),
-- 	('8', 'Auckland park', '-26.184278770616793', '28.006006635468395', '1.43', 'Kingsway place', 'true'),
-- 	('9', 'Soweto', '-26.24883637128098', '27.838288007294103', '12', 'Soweto', 'true'),
-- 	('10', 'Venda', '-23.09586633251248', '29.693043631229017', '12', 'Venda', 'true');


--     INSERT INTO "finances"."transaction_type" ("id", "label", "inventory") VALUES
-- 	('CIA', 'Customer income allocation', 'false'),
-- 	('CSA', 'Customer social allocation', 'false'),
-- 	('CWA', 'Customer wealth allocation', 'false'),
-- 	('CRC', 'Customer referral commission', 'false'),
-- 	('EIA', 'EESUpreneur income allocation', 'false'),
-- 	('TRF', 'Wallet Transfers', 'false'),
-- 	('EFT', 'Ozow EFT', 'false'),
-- 	('DEP', 'Depost', 'false'),
-- 	('ORD', 'Retail Order', 'false'),
-- 	('CRA', 'Customer Referral Allocation', 'false'),
-- 	('CSP', 'Customer Survey Participation', 'false'),
-- 	('CFV', 'Crowd Fund Voucher', 'false'),
-- 	('DAA', 'Distribution Admin Allocation', 'false');

    