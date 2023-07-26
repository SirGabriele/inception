all: up
	
up:
	sudo mkdir -p /home/kbrousse/data/mysql
	sudo mkdir -p /homekbrousse/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

start:
	docker-compose -f ./srcs/docker-compose.yml start

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

restart:
	docker-compose -f ./srcs/docker-compose.yml restart

fclean:
	docker system prune --volumes -af

.PHONY: all up down start stop restart fclean
