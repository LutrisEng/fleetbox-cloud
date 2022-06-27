WEB_SERVER ?= puma

.PHONY: build
build: version.txt commit.txt
	docker build .

.PHONY: deploy
deploy:
	fly deploy -c fly.toml --remote-only

.PHONY: deploy-staging
deploy-staging:
	fly deploy -c fly.staging.toml --remote-only

.PHONY: test
test: version.txt commit.txt
	mkdir -p junit
	chmod 777 junit
	docker compose -f ./docker-compose/tests.yml -p fleetbox_tests up --build --exit-code-from tests --renew-anon-volumes --force-recreate --remove-orphans
	chmod 755 junit

.PHONY: dev-server
dev-server: version.txt commit.txt
	docker compose -f ./docker-compose/development.yml -p fleetbox_dev_server up --build --exit-code-from web --renew-anon-volumes --force-recreate --remove-orphans

.PHONY: pre-pull
pre-pull:
	docker pull ruby:3.1.2-slim-bullseye
	docker pull ghcr.io/lutriseng/fleetbox-cloud:latest
	docker compose -f ./docker-compose/tests.yml -p fleetbox_tests pull
	docker compose -f ./docker-compose/development.yml -p fleetbox_dev_server pull

.PHONY: bundle-install
bundle-install:
	bundle package --all-platforms

.PHONY: local-tests
local-test:
	bin/rails db:schema:load
	bin/rails test:all:with[headless_chrome] TESTOPTS=--junit
	cp report.xml junit/

.PHONY: local-dev-server
local-dev-server:
	bin/rails db:schema:load
	bin/rails server -b 0.0.0.0

.PHONY: local-prod-server
local-prod-server:
	bin/rails server

.PHONY: local-migrate-db
local-migrate-db:
	bin/rails db:migrate

.PHONY: local-goodjob
local-goodjob:
	bin/good_job start

.PHONY: post-deploy
post-deploy: local-migrate-db

.PHONY: hello-world
hello-world:
	echo Hello, world!

TAG_COMMIT := $(shell git rev-list --abbrev-commit --tags --max-count=1)
TAG := $(shell git describe --abbrev=0 --tags ${TAG_COMMIT} 2>/dev/null || true)
COMMIT := $(shell git rev-parse --short HEAD)
DATE := $(shell git log -1 --format=%cd --date=format:"%Y%m%d")
VERSION := $(TAG:v%=%)
ifneq ($(COMMIT), $(TAG_COMMIT))
    VERSION := $(VERSION)-next-$(COMMIT)-$(DATE)
endif
ifeq ($(VERSION),)
    VERSION := $(COMMIT)-$(DATA)
endif
ifneq ($(shell git status --porcelain),)
    VERSION := $(VERSION)-dirty
endif

.PHONY: version.txt
version.txt:
	echo "fleetbox-cloud $(VERSION)" > version.txt

.PHONY: commit.txt
commit.txt:
	echo "$(COMMIT)" > commit.txt