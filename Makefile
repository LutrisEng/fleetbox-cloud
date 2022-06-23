.PHONY: build
build:
	docker build .

.PHONY: deploy
deploy:
	fly deploy

.PHONY: test
test:
	docker compose -f ./docker-compose/tests.yml -p fleetbox_tests up --build --exit-code-from tests --renew-anon-volumes --force-recreate --remove-orphans

.PHONY: dev-server
dev-server:
	docker compose -f ./docker-compose/development.yml -p fleetbox_dev_server up --build --exit-code-from web --renew-anon-volumes --force-recreate --remove-orphans

.PHONY: pre-pull
pre-pull:
	docker pull ruby:3.1.2-slim-bullseye
	docker compose -f ./docker-compose/tests.yml -p fleetbox_tests pull
	docker compose -f ./docker-compose/development.yml -p fleetbox_dev_server pull