import os
import subprocess
import sys

# Verify if the main.dart files is
#set to production and the flavors are properly set for both apps


eesup_root_path ="../eesup-frontend/apps/eesup/"
mykasi_app_path ="../eesup-frontend/apps/my_kasi_shop/lib/"


# app_paths = [eesup_root_path, mykasi_app_path]

# ... (paths)

def check_flavors(app_path, flavor_regex="Environment.production"):
    """Checks if the main.dart file in the given app_path is configured for a specific flavor.

    Args:
        app_path (str): Path to the directory containing the main.dart file.
        flavor_regex (str, optional): Regular expression to match the desired flavor. 
                                      Defaults to "Environment.production".

    Returns:
        bool: True if the flavor is found, False otherwise.
    """

    is_valid = False
    main_dart_path = os.path.join(app_path, "main.dart")

    try:
        with open(main_dart_path, 'r') as file:
            for line in file:
                if line.strip().__contains__(flavor_regex):
                    is_valid = True
                    break
    except FileNotFoundError:
        print(f"Error: main.dart not found in {app_path}")

    return is_valid

def build_app_bundles(path, pl, release_type):
    """Builds app bundles using shorebird."""

    print("Checking environment...")  # Add print statements for debugging
    is_valid = check_flavors(path + "lib/")

    if is_valid:
        print("Environment is valid. Starting build...")

    
        try:
            #Change the folder to the correct app and then build and app bundle
            #If the tests and the above futhur verifications pass
            subprocess.run(f"cd {path} && flutter build appbundle", shell=True)

            print("Build successful!")
        except OSError as e:
            print(f"Error during build: {e}")
    else:
        print("Environment is not valid for production build.")

def main():

    is_new_version = input("\nIs this a new version? (y/n) ")

    if is_new_version == "y":
        args = sys.argv

        if args.__len__ < 4:
            print("Usage: python release.py --app=APP_NAME --os=OS_NAME --release_type=APP_TYPE")
            return

        app = args[1]
        platform = args[2]
        release_type = args[3]


        currentPath = ''

        if app == "--app=eesup":
            currentPath = eesup_root_path
        elif app == "--app=my_kasi_shop":
            currentPath = mykasi_app_path
        else:
            print("Invalid app name.")
            return


        build_app_bundles(currentPath,platform, release_type)

    #build_app_bundles()
#   python release.py --app=eesup --os=ios
#   python release.py --app=eesup --os=android
    
if __name__ == "__main__":
    main()