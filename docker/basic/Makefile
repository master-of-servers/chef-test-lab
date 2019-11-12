run:
	bash create_ssh_key.sh
	docker-compose up -d --force-recreate --build

destroy:
	docker-compose stop
	docker-compose rm -f
