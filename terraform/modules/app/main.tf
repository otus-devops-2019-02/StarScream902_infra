resource "google_compute_instance" "rabbit-app" {
    name = "reddit-app"
    machine_type = "g1-small"
    zone = "${var.zone}"
    tags = ["reddit-app"]
    boot_disk {
        initialize_params {
            image = "${var.rabbit_app_disk_image}"
        }
    }
    network_interface {
        network = "default"
        access_config = {
                nat_ip = "${google_compute_address.rabbit-app_ip.address}"
        }
    }
    metadata {
        ssh-keys = "appuser:${file(var.public_key_path)}"
    }


	connection {
		type = "ssh"
		user = "appuser"
		agent = false
		# путь до приватного ключа
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

resource "google_compute_address" "rabbit-app_ip" {
    name = "reddit-app-ip"
}
resource "google_compute_firewall" "firewall_puma" {
    name = "allow-puma-default"
    network = "default"
    allow {
        protocol = "tcp"
        ports = ["9292"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["reddit-app"]
}