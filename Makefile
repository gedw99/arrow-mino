include help.mk

include caddy.mk
include minio.mk
include nats.mk
include overmind.mk

BIN=$(PWD)/.bin
export PATH:=$(PATH):$(BIN)

print:

dep-bin:
	mkdir -p $(BIN)
dep-tools: dep-bin
	# todo: add arg so we can put into .bin for easy deplyoment.
	$(MAKE) caddy-dep
	$(MAKE) minio-dep
	$(MAKE) nats-dep
	$(MAKE) overmind-dep

start-overmind:
	$(MAKE) overmind-run

CADDY_SRC_DOMAIN=localhost
run-caddy:
	$(MAKE) caddy-server-run
	
run-minio:
	$(MAKE) minio-server-run