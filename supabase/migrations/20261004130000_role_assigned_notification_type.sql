-- Own migration so the new enum value is committed before
-- 20261004130100_receiver_checklists.sql uses it.
ALTER TYPE "public"."notification_type" ADD VALUE IF NOT EXISTS 'role_assigned';
