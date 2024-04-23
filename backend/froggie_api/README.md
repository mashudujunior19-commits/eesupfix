# Froggie api
This the api for eesup and the white labels under eesup
# Pre-requisites
- Install Dart SDK (https://dart.dev/get-dart)
- Install Dart Frog (https://pub.dev/packages/dart_frog)
- Install Google Cloud SDK (https://cloud.google.com/sdk/docs/install)

#### 1. Run this command to build the project for development
```bash
dart_frog dev
```
#### 2. Run this command to build the project for production
```bash
dart_frog build
```
#### 3. Run this command to deploy on Google cloud for production
```bash
gcloud run deploy eesup-dart-frog-api --source build --allow-unauthenticated --region=us-central1
```

#### 4. Run this command to deploy on Google cloud for Testing and Development
```bash
gcloud run deploy eesup-dart-frog-dev-api --source build --allow-unauthenticated --region=us-central1
```

#### 5. Select the us-central1 region