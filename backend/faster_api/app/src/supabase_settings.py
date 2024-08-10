"""here is the dostring"""
from supabase import create_client, Client
from dotenv import dotenv_values


env_config = dotenv_values(".env.dev")

def supabase_client()->Client:
    url: str = env_config['SUPABASE_URL']
    key: str = env_config['SUPABASE_SERVICE_KEY']
    print(url)
    client: Client = create_client(url, key)
    return client
    