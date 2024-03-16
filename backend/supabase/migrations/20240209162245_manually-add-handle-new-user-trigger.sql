CREATE TRIGGER handle_new_user_trigger
AFTER UPDATE ON auth.users
FOR EACH ROW
EXECUTE FUNCTION public.handle_new_user();