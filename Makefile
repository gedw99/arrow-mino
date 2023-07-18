include help.mk

include caddy.mk
include go.mk
include minio.mk

include nats.mk
include overmind.mk

BIN=$(PWD)/.bin
# Pick your path based on OS and ARCH
export PATH:=$(PATH):$(BIN)/darwin_amd64

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
	$(MAKE) minio-dep
	$(MAKE) nats-dep
	$(MAKE) overmind-dep

### MINIO

1-minio:
	$(MAKE) minio-server-run

### CADDY

CADDY_SRC_DOMAIN=localhost
2-caddy:
	$(MAKE) caddy-server-run
	# https://browse.localhost/
	# https://minio-console.localhost/

3-sqlite:
	# TODO: make a makefile for this

### OVERMIND (procFile)

all-serve:
	# this will start all the services.
	$(MAKE) overmind-run

all-package:
	# todo: package for Desktops and Servers
	# go.mk has most of this already.
