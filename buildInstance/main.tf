provider "google" {
  credentials = file("servacc.json")
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
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = var.location
  cluster    = google_container_cluster.primary.name
  initial_node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 9
  }

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}