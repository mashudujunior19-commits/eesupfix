from supabase_settings import supabase_client


def fetch_auth_api_key(key: str):
    ''''''
    table = supabase_client.schema('system_configs').table('api_key')
    res = table.select('key', count=1)
    print(res)
    return res


# k = fetch_auth_api_key('eesup_Hjifg9zb8OHWwNgVhFqQXxRGKM1cYKobseMdAyqATsXa1UBGKDzZoPpQHLzsL6kXee0T6KFGpkm1tXEbxcUs609Jf12KBZg36ruuWBQDAqnCfl6xSXVd7vaAKHSC')
