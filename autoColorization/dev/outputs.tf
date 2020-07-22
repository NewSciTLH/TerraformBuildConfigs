output "VM_Network_IP" {
    value = google_compute_instance.default.network_interface.0.network_ip
}

output "VM_External_IP" {
    value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}

output "Container_Image" {
    value = var.container_image
}

output "Network_Used" {
    value = google_compute_network.vpc_network.name
}