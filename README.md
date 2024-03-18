**Project Setup and Structure Guide**

**Introduction**

This document outlines the prerequisites, setup instructions, and project directory structure to get started with the project.

**Prerequisites**

* **Flutter:** Download and install Flutter following the instructions at https://flutter.dev/docs/get-started/install
* **Melos:** Install globally using `pub global activate melos`  (https://pub.dev/packages/melos)
* **Dart:** Install Dart following instructions at  https://dart.dev/get-dart
* **Dart-Frog:** Install globally using `pub global activate dart_frog` (https://pub.dev/packages/dart_frog)

**Melos Usage**

We use Melos to streamline the management of our monorepo project. Here are key benefits and commands:

* **Efficient Management:** Melos links sub-packages, enabling seamless cross-package development.
* **Hot Reload:**  Changes to sub-packages automatically trigger updates, eliminating the need for manual `pub get` calls.
* **Simplified Commands:** The `melos.yaml` file defines aliases for common tasks:
    * `melos cl`: Equivalent to `flutter clean`
    * `melos pg`: Equivalent to `flutter pub get`

**Folder Structure**

1. **apps**: Contains individual Flutter applications:
     * **EESUp:** 
          * **android**
          * **ios**
          * **lib/main.dart** (Application entry point)
     * **MyKasiShop:** 
          * **android**
          * **ios**
          * **lib/main.dart** (Application entry point)

2. **packages**: Houses reusable code packages shared across applications:
    * **Data Sources:** Data access and communication logic
    * **Models:** Data representations 

3. **docs**: Project documentation.

4. **features**: This folder contains the core user interface (UI) components and business logic for the applications. Here's what makes it important:

   * **UI Building Blocks:**  Houses the reusable UI elements that form the visual structure of the apps.  
   * **Logic Hub:**  Implements the functionality and decision-making processes behind user interactions.
   * **Package Integration:**  This is where code from the shared packages (in the "packages" folder) comes together to create a cohesive user experience.
   * **Main Entry Point:** The `main.dart` files within the apps directly interact with the code in the "features" folder to bring everything to life.

5. **backend**: 
    * **supabase**: Database schema and migrations
    * **dart-frog**: Backend API powered by Dart Frog
