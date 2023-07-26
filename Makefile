all: up
	
up:
	mkdir -p /home/kbrousse/data/mysql
	mkdir -p /homekbrousse/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

.PHONY: all up down
