provider "google" {
    credentials = "../../../global/access.json"
    project = "aerobic-bonus-270814"
    region  = "europe-west2"
    zone    = "europe-west2-a"
}

terraform {
  backend "gcs" {
    credentials = "../../../global/access.json"
    bucket  = "test_terraform_bucket"
    prefix  = "terraform/stage/state"
  }
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}
