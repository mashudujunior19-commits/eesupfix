export PROJECT_ID=eesup-2ff69
export BILLING_ACCOUNT_ID=01EAD4-BF819E-5237A5
export APP2=fast_eesup 
export PORT=3000
export REGION="us-central1"
export TAG2="gcr.io/$PROJECT_ID/$APP"

# Set Default Project (all later commands will use it) 
gcloud config set project $PROJECT_ID