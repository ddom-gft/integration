# Filename: main.tf
# Configure GCP project
provider "google" {
  project = "amis-ocra-dev"
}
# Deploy image to Cloud Run
resource "google_cloud_run_service" "amis-ocra-iac" {
  name     = "amis-ocra-iac"
  location = "us-central1"
  template {
    spec {
      containers {
        image = "gcr.io/amis-ocra-dev/amis-ocra-iac"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}
# Create public access
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}
# Enable public access on Cloud Run service
resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.amis-ocra-dev.location
  project     = google_cloud_run_service.amis-ocra-dev.project
  service     = google_cloud_run_service.amis-ocra-dev.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
# Return service URL
output "url" {
  value = "${google_cloud_run_service.amis-ocra-dev.status[0].url}"
}