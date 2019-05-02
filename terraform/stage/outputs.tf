output "reddit-app_external_ip" {
  value = "${module.reddit-app.reddit-app_external-ip}"
}

output "reddit-db_external_ip" {
  value = "${module.reddit-db.reddit-db_external-ip}"
}

output "reddit-db_internal_ip" {
  value = "${module.reddit-db.reddit-db_internal-ip}"
}
