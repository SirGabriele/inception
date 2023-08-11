VOLUME_DIR =	/home/kbrousse/data

VOLUME_NAMES =	my_mariadb_volume	\
				my_wordpress_volume

all: up
	
up:
	sudo mkdir -p $(VOLUME_DIR)/mysql
	sudo mkdir -p $(VOLUME_DIR)/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

start:
	docker compose -f ./srcs/docker-compose.yml start

stop:
	docker compose -f ./srcs/docker-compose.yml stop

restart:
	docker compose -f ./srcs/docker-compose.yml restart

reload: down rmvolumes up clean

rmvolumes:
	@if [ -d $(VOLUME_DIR) ]; then \
		sudo rm -rf $(VOLUME_DIR); \
	fi

clean:
	@if docker images | grep -q none; then \
		docker rmi $$(docker images -f "dangling=true" -q) && echo "Removing the dangling images ..."; \
	fi

fclean: clean down rmvolumes
	docker system prune --volumes -af
	docker volume rm $$(docker volume ls -q)

.PHONY: all up down start stop restart rmvolumes fclean clean reload
