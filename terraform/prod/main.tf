terraform {
	# Версия terraform
	required_version = ">= 0.11.7, <= 0.11.13"
}

provider "google" {
	# Версия провайдера
	version = "2.0.0"
	# ID проекта
	# project = "corded-aquifer-235018"
	project = "${var.project}"
	# region = "europe-north1"
	region = "${var.region}"
}

module "rabbit-app" {
	source = "../modules/app"
	public_key_path = "${var.public_key_path}"
	zone = "${var.zone}"
	rabbit_app_disk_image = "${var.rabbit_app_disk_image}"
}
module "rabbit-db" {
	source = "../modules/db"
	public_key_path = "${var.public_key_path}"
	zone = "${var.zone}"
	rabbit_db_disk_image = "${var.rabbit_db_disk_image}"
}

module "vpc" {
	source = "../modules/vpc"
}
