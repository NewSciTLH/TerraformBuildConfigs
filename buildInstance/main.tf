provider "google" {
  credentials = file("../servacc.json")
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "default" {
  name     = "basic-vm"
  description = "Basic Compute Instance Virtual Machine"
  machine_type = var.machine_type
  zone = var.zone
  can_ip_forward = false
  deletion_protection = false

  tags = ["basic"]

  scheduling {
    preemptible = true
    automatic_restart = false
    on_host_maintenance = "TERMINATE"
  }
  
  # Scheduling for non-preemptible instance without GPU. (Last indefinitely until terminated.)
  # scheduling {
  #   preemptible = false
  #   automatic_restart = true
    # on_host_maintenance = "MIGRATE" # Instances with Guest Accelerators don't support live migration.
  # }
  
  # Scheduling for a preemptible instance. (Lasts 24 hrs.)
  # scheduling {
  #   preemptible = true
  #   automatic_restart = false
  #   on_host_maintenance = "TERMINATE"
  # }

  labels = {
    environment = "test"
  }

  boot_disk {
    auto_delete = true
    device_name = "basic_disk"
    initialize_params {
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

  # Adding GPU to Instance.
  # guest_accelerator {
  #   type = "nvidia-tesla-p100"
  #   count = 1
  # }
}