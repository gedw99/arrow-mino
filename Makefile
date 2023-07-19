include help.mk

include caddy.mk
include fly.mk
include go.mk
include hcloud.mk
include minio.mk
include nats.mk
include overmind.mk

BIN=$(PWD)/.bin
# Pick your path based on OS and ARCH
export PATH:=$(PATH):$(BIN):$(BIN)/darwin_amd64

BIN_SQLITE_NAME=sqlite
BIN_SQLITE=$(BIN)/$(BIN_SQLITE_NAME)


print:
	@echo ""
	@echo "BIN:    $(BIN)"

### DEPS

0-dep: dep-tools

dep-bin:
	mkdir -p $(BIN)
dep-bin-del:
	rm -rf $(BIN)

MINIO_SRC_OUT_FSPATH=$(BIN)
dep-tools: dep-bin
	# todo: add arg so we can put into .bin for easy deplyoment.
	$(MAKE) caddy-dep
	$(MAKE) fly-dep
	$(MAKE) go-dep
	$(MAKE) hcloud-dep
	$(MAKE) minio-dep
	$(MAKE) nats-dep
	$(MAKE) overmind-dep

### MINIO

1-minio:
	$(MAKE) minio-server-run

2-sqlite:
	# build to .bin
	cd cmd/sqlite && go build -o $(BIN_SQLITE) .

	# todo: cross build. Need to add OUT Path to go.mk
	$(MAKE) GO_SRC_FSPATH=$(PWD)/cmd/sqlite GO_SRC_NAME=$(BIN_SQLITE_NAME) go-build
	
	# run it
	$(BIN_SQLITE_NAME)
	# 127.0.0.1:57077

3-nats:
	$(MAKE) nats-server-run
	# Listening for websocket clients on wss://0.0.0.0:443
	# Listening for client connections on 0.0.0.0:4222

### CADDY

CADDY_SRC_DOMAIN=localhost
10-caddy:
	$(MAKE) caddy-server-run
	# https://browse.localhost/
	# https://minio-console.localhost/
	# https://sqlite.localhost/


### OVERMIND (procFile)

20-overmind:
	# this will start all the services.
	$(MAKE) overmind-run

30-package:
	# copy all the right bits into "pack" folder ?

	# todo: 
	# package for Desktops and Servers
		# go.mk has most of this already.
	# Docker with all bins and envs inside
		# test on fly.io

### DEPLOY

FLY_SRC_FSPATH=$(BIN)
FLY_SRC_APP=arrow-minio-app
FLY_SRC_NAME=arrow-minio
40-deploy:
	# todo: finish docker and steps
	# - build docker in github or with fly remote build ? fly remote build is easier
	$(MAKE) fly-deploy
