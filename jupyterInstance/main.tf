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
    environment = "jupyter"
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
    network = google_compute_network.default.self_link

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    Owner = "JeremyQ"
  }

  metadata_startup_script = file("startup.sh")

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  # Adding GPU to Instance.
  # guest_accelerator {
  #   type = "nvidia-tesla-p100"
  #   count = 1
  # }
}

resource "google_compute_firewall" "default" {
  name    = "default-test-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  enable_logging = true
  source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "default-test-network"
  auto_create_subnetworks = "true"
}