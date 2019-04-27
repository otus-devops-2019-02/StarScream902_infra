output "reddi-app_external-ip" {
  value = "${google_compute_instance.reddi-app.network_interface.0.access_config.0.nat_ip}"
}
