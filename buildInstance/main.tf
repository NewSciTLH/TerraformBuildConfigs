provider "google" {
  credentials = file("../servacc.json")
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "default" {
  name     = "Basic VM"
  description = "Basic Compute Instance Virtual Machine"
  machine_type = var.machine_type
  zone = var.zone
  can_ip_forward = false
  deletion_protection = false

  tags = ["basic"]

  scheduling = {
    preemtible = true
    automatic_restart = true
    on_host_maintenance = "MIGRATE"
  }

  labels = {
    enviroment = "test"
  }

  boot_disk {
    initialize_params {
      auto_delete = true
      device_name = "basic_disk"
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    Owner = "JeremyQ"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  guest_accelerator {
    type = "nvidia-tesla-k80"
    count = 1
  }
}