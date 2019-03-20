# StarScream902_infra
StarScream902 Infra repository

this is simplify solve for access to host behind publicly accessible

ssh -tt -i ~/path/to/privat/key -A user@ip-to-public-host ssh user@ip-to-privat-host

for more solves follow https://habr.com/ru/post/122445/

bastion_IP = 35.211.108.109 
someinternalhost_IP = 10.142.0.3
