"""here is the dostring"""
import os
from supabase import create_client, Client


SUPABASE_URL: str = os.getenv('SUPABASE_URL')
SUPABASE_KEY: str = os.getenv('SUPABASE_SERVICE_KEY')

supabase_client: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
