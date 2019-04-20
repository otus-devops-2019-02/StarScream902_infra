output "rabbi-app_external-ip" {
  value = "${google_compute_instance.rabbit-app.network_interface.0.access_config.0.nat_ip}"
}
