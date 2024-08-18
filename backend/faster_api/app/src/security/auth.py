from app.src.supabase_settings import supabase_client


def fetch_auth_api_key(key: str):
    """"""
    table = supabase_client().schema("system_configs").table("api_key")
    res = table.select("key").eq("key", key)
    print(res)

    return res
