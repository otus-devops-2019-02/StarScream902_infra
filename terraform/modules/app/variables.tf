variable zone {
  description = "zone"

  # Значение по умолчанию
  default = "europe-north1-c"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
  default = "~/.ssh/GitHub-StarScream902-pub"
}

variable private_key_path {
  # Описание переменной
  description = "Path to the private key used for ssh access"
  default = "~/.ssh/GitHub-StarScream902-priv.OpenSSH"
}

variable rabbit_app_disk_image {
  description = "Disk image"
}
