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

module "reddit-app" {
  source                = "../modules/app"
  public_key_path       = "${var.public_key_path}"
  zone                  = "${var.zone}"
  reddit_app_disk_image = "${var.reddit_app_disk_image}"
  ssh_user             = "${var.ssh_user}"
  private_key_path = "${var.private_key_path}"
}

module "reddit-db" {
  source               = "../modules/db"
  public_key_path      = "${var.public_key_path}"
  zone                 = "${var.zone}"
  reddit_db_disk_image = "${var.reddit_db_disk_image}"
  ssh_user             = "${var.ssh_user}"
  private_key_path = "${var.private_key_path}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
