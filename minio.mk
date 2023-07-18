# minio-dep
# https://dl.min.io/server/minio/release/


# go


MINIO_GO_BIN_NAME=go

# Computed variables
MINIO_GO_PATH?= $(shell $(MINIO_GO_BIN_NAME) env GOPATH)
# override for testing only.
#MINIO_GO_OS=windows
MINIO_GO_OS=$(shell $(MINIO_GO_BIN_NAME) env GOOS)
MINIO_GO_ARCH=$(shell $(MINIO_GO_BIN_NAME) env GOARCH)


# bin
MINIO_SRC_OUT_FSPATH=$(MINIO_GO_PATH)/bin
#MINIO_SRC_OUT_FSPATH=$(PWD)/.bin

MINIO_BIN=$(MINIO_SRC_OUT_FSPATH)/$(MINIO_GO_OS)_$(MINIO_GO_ARCH)
MINIO_BIN_WINDOWS=$(MINIO_SRC_OUT_FSPATH)/windows_$(MINIO_GO_ARCH)
MINIO_BIN_DARWIN=$(MINIO_SRC_OUT_FSPATH)/darwin_$(MINIO_GO_ARCH)
MINIO_BIN_LINUX=$(MINIO_SRC_OUT_FSPATH)/linux_$(MINIO_GO_ARCH)

MINIO_DOWNLOAD_SERVER_URL_PREFIX=https://dl.min.io/server/minio/release
MINIO_DOWNLOAD_CLIENT_URL_PREFIX=https://dl.min.io/client/mc/release


# templates
MINIO_SRC_TEMPLATES_FSPATH=$(PWD)/.templates/minio
_MINIO_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
_MINIO_TEMPLATES_SOURCE=$(_MINIO_SELF_DIR)/templates/minio
_MINIO_TEMPLATES_TARGET=$(MINIO_SRC_TEMPLATES_FSPATH)

minio-print: minio-dep-print minio-env-print

minio-dep-print:
	@echo ""
	@echo "-- DEP --"
	@echo ""
	@echo "-- GO --"
	@echo "MINIO_GO_PATH:           $(MINIO_GO_PATH)"
	@echo "MINIO_GO_OS:             $(MINIO_GO_OS)"
	@echo "MINIO_GO_ARCH:           $(MINIO_GO_ARCH)"
	@echo ""
	@echo "-- BIN --"
	@echo "MINIO_BIN_NAME_MINIO:    $(MINIO_BIN_NAME_MINIO)"
	@echo "MINIO_BIN_NAME_MC        $(MINIO_BIN_NAME_MC)"
	
	@echo "MINIO_BIN:               $(MINIO_BIN)"
	@echo "MINIO_BIN_WINDOWS:       $(MINIO_BIN_WINDOWS)"
	@echo "MINIO_BIN_DARWIN:        $(MINIO_BIN_DARWIN)"
	@echo "MINIO_BIN_LINUX:         $(MINIO_BIN_LINUX)"
	@echo "MINIO_SRC_OUT_FSPATH:    $(MINIO_SRC_OUT_FSPATH)"

	
	
## prints the templates
minio-templates-print:
	@echo ""
	@echo "-- TEMPLATES --"
	@echo "_MINIO_SELF_DIR:                   $(_MINIO_SELF_DIR)"
	@echo "_MINIO_TEMPLATES_SOURCE:           $(_MINIO_TEMPLATES_SOURCE)"
	@echo "_MINIO_TEMPLATES_TARGET:           $(_MINIO_TEMPLATES_TARGET)"
	
	@echo ""
	@echo listing templates ...

	cd $(_MINIO_TEMPLATES_SOURCE) && ls -al


## installs the minio templates into your project
minio-templates-dep:
	@echo
	@echo installing minio templates to your project....
	mkdir -p $(_MINIO_TEMPLATES_TARGET)
	cp -r $(_MINIO_TEMPLATES_SOURCE)/* $(_MINIO_TEMPLATES_TARGET)/
	@echo installed minio templates  at : $(_MINIO_TEMPLATES_TARGET)


MINIO_BIN_NAME_MINIO=?
MINIO_BIN_NAME_MC=?
ifeq ($(MINIO_GO_OS),windows)
	MINIO_BIN_NAME_MINIO=minio.exe
	MINIO_BIN_NAME_MC=mc.exe
endif

ifeq ($(MINIO_GO_OS),darwin)
	MINIO_BIN_NAME_MINIO=minio
	MINIO_BIN_NAME_MC=mc
endif

ifeq ($(MINIO_GO_OS),linux)
	MINIO_BIN_NAME_MINIO=minio
	MINIO_BIN_NAME_MC=mc
endif 

minio-dep-pre:
	go install github.com/hashicorp/go-getter/cmd/go-getter@latest


minio-dep: minio-dep-pre
ifeq ($(MINIO_GO_OS),windows)
	$(MAKE) minio-dep-windows
endif

ifeq ($(MINIO_GO_OS),darwin)
	$(MAKE) minio-dep-darwin
endif

ifeq ($(MINIO_GO_OS),linux)
	minio-dep-linux
endif 

minio-dep-all: minio-dep-pre minio-dep-windows minio-dep-darwin minio-dep-linux

minio-dep-windows:
	go-getter -progress -mode=file $(MINIO_DOWNLOAD_SERVER_URL_PREFIX)/windows-amd64/minio.exe $(MINIO_BIN_WINDOWS)/minio.exe
	go-getter -progress -mode=file $(MINIO_DOWNLOAD_CLIENT_URL_PREFIX)/windows-amd64/mc.exe $(MINIO_BIN_WINDOWS)/mc.exe
	
	chmod +x $(MINIO_BIN_WINDOWS)/minio.exe
	chmod +x $(MINIO_BIN_WINDOWS)/mc.exe
	
minio-dep-darwin:
	# darwin-amd64/minio
	go-getter -progress -mode=file $(MINIO_DOWNLOAD_SERVER_URL_PREFIX)/darwin-amd64/minio $(MINIO_BIN_DARWIN)/minio
	go-getter -progress -mode=file $(MINIO_DOWNLOAD_CLIENT_URL_PREFIX)/darwin-amd64/mc $(MINIO_BIN_DARWIN)/mc
	
	chmod +x $(MINIO_BIN_DARWIN)/minio
	chmod +x $(MINIO_BIN_DARWIN)/mc
	
minio-dep-linux:
	go-getter -progress -mode=file $(MINIO_DOWNLOAD_SERVER_URL_PREFIX)/linux-amd64/minio $(MINIO_BIN_LINUX)/minio
	go-getter -progress -mode=file $(MINIO_DOWNLOAD_CLIENT_URL_PREFIX)/linux-amd64/mc $(MINIO_BIN_LINUX)/mc
	
	chmod +x $(MINIO_BIN_LINUX)/minio
	chmod +x $(MINIO_BIN_LINUX)/mc

### Delete

minio-dep-del:
	
ifeq ($(MINIO_GO_OS),windows)
	$(MAKE) minio-dep-del-windows
endif

ifeq ($(MINIO_GO_OS),darwin)
	$(MAKE) minio-dep-del-darwin
endif

ifeq ($(MINIO_GO_OS),linux)
	$(MAKE) minio-dep-del-linux
endif 

minio-dep-del-all: minio-dep-del-windows minio-dep-del-darwin minio-dep-del-linux
	

minio-dep-del-windows:
	rm -f $(MINIO_BIN_WINDOWS)/minio.exe
	rm -f $(MINIO_BIN_WINDOWS)/mc.exe

minio-dep-del-darwin:
	rm -f $(MINIO_BIN_DARWIN)/minio
	rm -f $(MINIO_BIN_DARWIN)/mc

minio-dep-del-linux:
	rm -f $(MINIO_BIN_LINUX)/minio
	rm -f $(MINIO_BIN_LINUX)/mc




### env

MINIO_ENV_DATA_FSPATH=$(PWD)/.data/minio
MINIO_ENV_CONFIG_FSPATH=$(HOME)/.minio
export MINIO_ENV_ROOT_USER=moyllith10
export MINIO_ENV_ROOT_PASSWORD=moyllith10

minio-env-print:
	@echo ""
	@echo "-- ENV --"
	@echo "Override variables:"
	@echo "MINIO_ENV_DATA_FSPATH:             $(MINIO_ENV_DATA_FSPATH)"
	@echo "MINIO_ENV_CONFIG_FSPATH:           $(MINIO_ENV_CONFIG_FSPATH)"
	@echo "MINIO_ENV_ROOT_USER:               $(MINIO_ENV_ROOT_USER)"
	@echo "MINIO_ENV_ROOT_PASSWORD:           $(MINIO_ENV_ROOT_PASSWORD)"



## run server

minio-server-help:
	$(MINIO_BIN_NAME_MINIO) -h

minio-server-run:
	
	$(MINIO_BIN_NAME_MINIO) server  --console-address :9001 $(MINIO_ENV_DATA_FSPATH)
	#minio server --console-address :9000 .data/minio
	# http://192.168.2.100:58796/

minio-server-config:
	# https://github.com/minio/minio/blob/master/docs/config/README.md
	ls ~/.minio

minio-server-data:
	ls $(MINIO_ENV_DATA_FSPATH)

## run cli

minio-cli-help:
	$(MINIO_BIN_NAME_MC) -h
minio-cli-run:	
	$(MINIO_BIN_NAME_MC) 
minio-cli-config:
	# https://github.com/minio/mc/blob/master/docs/minio-client-configuration-files.md
	ls ~/.mc


