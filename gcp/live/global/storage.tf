provider "google" {
    credentials = file("access.json")
    project = "aerobic-bonus-270814"
    region  = "europe-west2"
}

terraform {
  backend "gcs" {
    credentials = "access.json"
    bucket  = "test_terraform_bucket"
    prefix  = "terraform/state"
  }
}

resource "google_storage_bucket" "first_test" {
  name          = "test_terraform_bucket"
  location      = "EU"
  force_destroy = true

  bucket_policy_only = true

}





