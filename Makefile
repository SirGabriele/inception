VOLUME_DIR =	/home/kbrousse/data

VOLUME_NAMES =	my_mariadb_volume	\
				my_wordpress_volume

all: up
	
up:
	sudo mkdir -p $(VOLUME_DIR)/mysql
	sudo mkdir -p $(VOLUME_DIR)/wordpress
	docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml down
	#docker volume rm $(VOLUME_NAMES) #A VIRER--------------------------------------------------------------------------------
	#sudo rm -rf $(VOLUME_DIR) #A VIRER--------------------------------------------------------------------------------

start:
	docker-compose -f ./srcs/docker-compose.yml start

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

restart:
	docker-compose -f ./srcs/docker-compose.yml restart

rmvolumes:
	@if [ -d $(VOLUME_DIR) ]; then \
		sudo rm -rf $(VOLUME_DIR); \
	fi

clean:
	docker rmi $$(docker images -f "dangling=true" -q)

fclean: rmvolumes
	docker system prune --volumes -af
	docker volume rm $(VOLUME_NAMES)
	sudo rm -rf $(VOLUME_DIR)

.PHONY: all up down start stop restart rmvolumes fclean clean
