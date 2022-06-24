WEB_SERVER ?= puma

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

.PHONY: local-tests
local-test:
	bin/rails db:schema:load
	bin/rails test:all:with[headless_firefox] TESTOPTS=--junit
	cp report.xml junit/

.PHONY: local-dev-server
local-dev-server:
	bin/rails db:schema:load
	bin/rails server $(WEB_SERVER) -b 0.0.0.0

.PHONY: local-prod-server
local-prod-server:
	bin/rails server $(WEB_SERVER)

.PHONY: local-migrate-db
local-migrate-db:
	bin/rails db:migrate

.PHONY: post-deploy
post-deploy: local-migrate-db