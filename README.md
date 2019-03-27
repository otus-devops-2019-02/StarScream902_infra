# StarScream902_infra
StarScream902 Infra repository

this is simplify solve for access to host behind publicly accessible

ssh -tt -i ~/path/to/privat/key -A user@ip-to-public-host ssh user@ip-to-privat-host

for more solves follow https://habr.com/ru/post/122445/

bastion_IP = 35.211.108.109 
someinternalhost_IP = 10.142.0.11

testapp_IP = 35.198.167.169
testapp_port = 9292

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
gcloud compute instances create reddit-app\
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
