run:
	bash create_ssh_key.sh
	docker-compose up -d --force-recreate --build
	@echo You will need to wait about 15 minutes before you can use the environment, go grab a beverage!

destroy:
	docker-compose down -v
