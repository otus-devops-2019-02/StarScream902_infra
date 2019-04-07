terraform {
	# Версия terraform
	# required_version = "0.11.13"
	required_version = "0.11.7"
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

resource "google_compute_instance" "app" {
	name = "reddit-app"
	machine_type = "g1-small"
	# zone = "europe-north1-c"
	zone = "${var.zone}"
	tags = ["reddit-app"]
	# определение загрузочного диска
	boot_disk {
		initialize_params {
			#image = "reddit-base"
			image = "${var.disk_image}"
		}
	}
	# определение сетевого интерфейса
	network_interface {
		# сеть, к которой присоединить данный интерфейс
		network = "default"
		# использовать ephemeral IP для доступа из Интернет
		access_config {}
	}
	
	metadata {
		# путь до публичного ключа
		# ssh-keys = "starscream902:${file("~/.ssh/GitHub-StarScream902-pub")}"
		ssh-keys = "starscream902:${file(var.public_key_path)}"
	}

	connection {
		type = "ssh"
		user = "starscream902"
		agent = false
		# путь до приватного ключа
		# private_key = "${file("~/.ssh/GitHub-StarScream902-priv.OpenSSH")}"
		private_key = "${file(var.private_key_path)}"
	}

	provisioner "file" {
		source = "files/puma.service"
		destination = "/tmp/puma.service"
	}

	provisioner "remote-exec" {
		script = "files/deploy.sh"
	}
}

resource "google_compute_firewall" "firewall_puma" {
	name = "allow-puma-default"
	# Название сети, в которой действует правило
	network = "default"
	# Какой доступ разрешить
	allow {
		protocol = "tcp"
		ports = ["9292"]
	}
	# Каким адресам разрешаем доступ
	source_ranges = ["0.0.0.0/0"]
	# Правило применимо для инстансов с перечисленными тэгами
	target_tags = ["reddit-app"]
}