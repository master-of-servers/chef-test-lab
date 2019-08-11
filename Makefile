build:
	bash create_ssh_key.sh

run:
	vagrant up

destroy:
	vagrant destroy -f
