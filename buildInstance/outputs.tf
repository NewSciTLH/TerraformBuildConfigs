output "VM_Network_IP" {
    value = google_compute_instance.default.network_interface.0.network_ip
}

output "VM_External_IP" {
    value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}