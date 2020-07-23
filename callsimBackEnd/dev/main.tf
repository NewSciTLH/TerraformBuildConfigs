provider "google" {
  credentials = file("../servacc.json")
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "default" {
  name     = "dev-call-sim-backend"
  description = "Compute instance mimicing a node of the Auto Colorization GKE Cluster. Used for development purposes."
  machine_type = var.machine_type
  zone = var.zone
  can_ip_forward = false
  deletion_protection = false

  tags = ["development"]

  scheduling {
    preemptible = false
    automatic_restart = true
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
    environment = "dev"
    container-vm = module.gce-container.vm_container_label
  }

  boot_disk {
    # auto_delete = true
    initialize_params {
      image = module.gce-container.source_image
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = google_compute_network.vpc_network.id

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    Owner = "NewSci-911"
    gce-container-declaration = module.gce-container.metadata_value
  }

  # metadata_startup_script = "docker run -p 5000:5000 ${var.container_image} "

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  # Adding GPU to Instance.
  # guest_accelerator {
  #   type = "nvidia-tesla-k80"
  #   count = 1
  # }
}

resource "google_compute_network" "vpc_network" {
  name = "dev-call-sim-backend-network"
}

resource "google_compute_firewall" "port-access" {
  name    = "open-flask-port-dev-call-sim-backend"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = ["22", "80", "5000"]
  }

  source_ranges = ["0.0.0.0/0"]
}