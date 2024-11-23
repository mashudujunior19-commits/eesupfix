CREATE TRIGGER handle_new_user_trigger AFTER UPDATE ON auth.users FOR EACH ROW EXECUTE FUNCTION handle_new_user();

CREATE TRIGGER trigger_handle_new_user AFTER UPDATE ON auth.users FOR EACH ROW EXECUTE FUNCTION handle_new_user();


set check_function_bodies = off;

CREATE OR REPLACE FUNCTION storage.extension(name text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
_parts text[];
_filename text;
BEGIN
    select string_to_array(name, '/') into _parts;
    select _parts[array_length(_parts,1)] into _filename;
    -- @todo return the last part instead of 2
    return split_part(_filename, '.', 2);
END
$function$
;

CREATE OR REPLACE FUNCTION storage.filename(name text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
_parts text[];
BEGIN
    select string_to_array(name, '/') into _parts;
    return _parts[array_length(_parts,1)];
END
$function$
;

CREATE OR REPLACE FUNCTION storage.foldername(name text)
 RETURNS text[]
 LANGUAGE plpgsql
AS $function$
DECLARE
_parts text[];
BEGIN
    select string_to_array(name, '/') into _parts;
    return _parts[1:array_length(_parts,1)-1];
END
$function$
;

create policy "Give users authenticated access rzmirc_0"
on "storage"."objects"
as permissive
for select
to authenticated
using (((bucket_id = 'message_attachments'::text) AND (auth.role() = 'authenticated'::text)));


create policy "Give users authenticated access rzmirc_1"
on "storage"."objects"
as permissive
for insert
to authenticated
with check (((bucket_id = 'message_attachments'::text) AND (auth.role() = 'authenticated'::text)));



