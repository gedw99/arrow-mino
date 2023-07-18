include help.mk

include caddy.mk
include fly.mk
include go.mk
include minio.mk
include nats.mk
include overmind.mk

BIN=$(PWD)/.bin
# Pick your path based on OS and ARCH
export PATH:=$(PATH):$(BIN):$(BIN)/darwin_amd64

BIN_SQLITE_NAME=sqlite
BIN_SQLITE=$(BIN)/$(BIN_SQLITE_NAME)


print:

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
	$(MAKE) minio-dep
	$(MAKE) nats-dep
	$(MAKE) overmind-dep

### MINIO

1-minio:
	$(MAKE) minio-server-run


2-sqlite:
	# TODO: make a makefile for this

	# build to .bin
	cd cmd/sqlite && go build -o $(BIN_SQLITE) .

	# run it
	$(BIN_SQLITE_NAME)
	# 127.0.0.1:57077

### CADDY

CADDY_SRC_DOMAIN=localhost
10-caddy:
	$(MAKE) caddy-server-run
	# https://browse.localhost/
	# https://minio-console.localhost/
	# https://sqlite.localhost/


### OVERMIND (procFile)

all-serve:
	# this will start all the services.
	$(MAKE) overmind-run

all-package:
	# todo: package for Desktops and Servers
	# go.mk has most of this already.
