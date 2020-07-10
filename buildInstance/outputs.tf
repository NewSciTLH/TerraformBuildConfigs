output "VM_Network_IP" {
    value = google_compute_instance.default.network_interface.0.network_ip
}