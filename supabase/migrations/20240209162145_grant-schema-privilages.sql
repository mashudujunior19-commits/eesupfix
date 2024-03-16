GRANT USAGE ON SCHEMA finances TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA finances TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA finances TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA finances TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA finances GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA finances GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA finances GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;


GRANT USAGE ON SCHEMA geolocations TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA geolocations TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA geolocations TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA geolocations TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA geolocations GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA geolocations GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA geolocations GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;

GRANT USAGE ON SCHEMA communities TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA communities TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA communities TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA communities TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA communities GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA communities GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA communities GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;

GRANT USAGE ON SCHEMA engagements TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA engagements TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA engagements TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA engagements TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA engagements GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA engagements GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA engagements GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;


GRANT USAGE ON SCHEMA inventory TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA inventory TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA inventory TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA inventory TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA inventory GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA inventory GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA inventory GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;

GRANT USAGE ON SCHEMA sales TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA sales TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA sales TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA sales TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA sales GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA sales GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA sales GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;


GRANT USAGE ON SCHEMA services TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA services TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA services TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA services TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA services GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA services GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA services GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;

GRANT USAGE ON SCHEMA system_configs TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA system_configs TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA system_configs TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA system_configs TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA system_configs GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA system_configs GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA system_configs GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;


GRANT USAGE ON SCHEMA warehousing TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA warehousing TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA warehousing TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA warehousing TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA warehousing GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA warehousing GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA warehousing GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;