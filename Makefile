# Nom du réseau Docker
NETWORK=network

# Noms des images et conteneurs
FRONT_IMAGE=front
FRONT_CONTAINER=frontend

# Ports
FRONT_PORT=3000

# Commandes de lancement
up: network build run

network:
	docker network inspect $(NETWORK) >/dev/null 2>&1 || docker network create $(NETWORK)

build:
	docker build -t $(FRONT_IMAGE) .

run:
	docker run -d --name $(FRONT_CONTAINER) --network=$(NETWORK) -p $(FRONT_PORT):3000 $(FRONT_IMAGE)

stop:
	docker stop $(FRONT_CONTAINER) || true

clean: stop
	docker rm $(FRONT_CONTAINER) || true
	docker rmi $(FRONT_IMAGE) || true

logs-front:
	docker logs -f $(FRONT_CONTAINER)

rebuild: clean up
