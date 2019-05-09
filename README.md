# StarScream902_infra
StarScream902 Infra repository

this is simplify solve for access to host behind publicly accessible

ssh -tt -i ~/path/to/privat/key -A user@ip-to-public-host ssh user@ip-to-privat-host

for more solves follow https://habr.com/ru/post/122445/

bastion_IP = 35.211.108.109 
someinternalhost_IP = 10.142.0.11

testapp_IP = 35.243.145.17
testapp_port = 9292

#=======================================
#======== Google Cloud Platform ========
#=======================================

#Command for creating firewall rule

gcloud compute firewall-rules create puma-server \
	--no-enable-logging \
	--network default \
	--priority 1000 \
	--direction ingress \
	--action allow \
	--target-tags puma-server \
	--source-ranges 0.0.0.0/0 \
	--rules tcp:9292 \
	--no-disabled

#Docs 
#https://cloud.google.com/vpc/docs/using-firewalls

#Command for creatin VM-instance with startup script

gcloud compute instances create reddit-app \
  --zone=europe-north1-b \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata startup-script-url=https://gist.githubusercontent.com/StarScream902/768b5c669e348958e546f7e2bbf8a203/raw/e3aa31f7dc6e38f3e19b91cf62a5affd17c273ef/startup-script

#Docs 
#https://cloud.google.com/sdk/gcloud/reference/compute/instances/create
#https://cloud.google.com/compute/docs/startupscript

#========================
#======== Packer ========
#========================

Packer dock
https://www.packer.io/docs/index.html

#===========================
#======== Terraform ========
#===========================

terraform docs
https://www.terraform.io/docs/index.html

#=========================
#======== Vagrant ========
#=========================

Vagrant docks
https://www.vagrantup.com/docs/index.html

Vagrant ansible provisioning
https://www.vagrantup.com/docs/provisioning/ansible.html	
https://www.vagrantup.com/docs/provisioning/ansible_common.html

Для тестирования Ansible плэйбуков/ролей в Vagrant нужно описать provision директиву с указанием плэйбуков/ролей, которые будут там выполняться при создании VM (vagrant up), или после создания VM (vagrant provision VM_NAME) запуск provision в них, которыйе будут выполнять плэйбуки/ролеи, которые в них указаны.
Так же следует сразу в JSON формате указать переменные для запуска этих плэйбуков/ролей, в директивах ansible.groups или ansible.extra_vars

#==== Molecule + Testinfra ====

Molecule docs
https://molecule.readthedocs.io/en/stable/index.html

Testinfra docks
https://testinfra.readthedocs.io/en/latest/

Расширенное автоматическое тестирование ролей можно реализовать через программу Molecule и модули к ней testinfra и python-vagrant.
Программы написаны на Python и ставятся через pip - менеджер пакетов python

molecule>=2.20
testinfra>=1.10
python-vagrant>=0.5.15

для инициализации тестов, в директории роли нужно выполнить команду molecule init
Далее, в файлк molecule/default/tests/test_default.py написать все интересующие тесты для Testinfra

В файле db/molecule/default/molecule.yml, если нужно, описать тестовую машину, которую будет создавать molecule

Для создания тестовой VM надо выполнить комманду (molecule create) 
molecule list покажет все созданные VM
Так же можно подключиться к этой VM командой (molecule login -h instance_NAME)
В файле db/molecule/default/playbook.yml находится плэйбук, которым запускается роль для проверки, по желанию, его можно скорректировать
molecule converge - применяет изменения
molecule verify - запуск тестов Testinfra
molecule test - выполняет lint тесты роли
