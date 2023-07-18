# fly

# https://github.com/superfly/flyctl

FLY_GO_BIN_NAME=go
FLY_GO_PATH?= $(shell $(FLY_GO_BIN_NAME) env GOPATH)
# override for testing only.
#FLY_GO_OS=linux
FLY_GO_OS=$(shell $(FLY_GO_BIN_NAME) env GOOS)
FLY_GO_ARCH=$(shell $(FLY_GO_BIN_NAME) env GOARCH)



# https://github.com/superfly/flyctl/tags
FLY_SRC_VERSION=0.1.56
# default to .bin, as then most users wil have a .gitingore for it.
FLY_SRC_OUT_FSPATH=$(PWD)/.bin

# computed
FLY_BIN=$(FLY_SRC_OUT_FSPATH)/$(FLY_GO_OS)_$(FLY_GO_ARCH)
FLY_BIN_WINDOWS=$(FLY_SRC_OUT_FSPATH)/windows_$(FLY_GO_ARCH)
FLY_BIN_DARWIN=$(FLY_SRC_OUT_FSPATH)/darwin_$(FLY_GO_ARCH)
FLY_BIN_LINUX=$(FLY_SRC_OUT_FSPATH)/linux_$(FLY_GO_ARCH)

# const
# https://github.com/superfly/flyctl/releases/download/v0.1.56/flyctl_0.1.56_macOS_x86_64.tar.gz
FLY_DOWNLOAD_URL_PREFIX=https://github.com/superfly/flyctl/releases/download


## Environmental
# https://fly.io/docs/flyctl/integrating/
FLY_CONFIG_FSPATH=$(HOME)/.fly/
FLY_AUTH_TOKEN=$(shell $(FLY_BIN) auth token)
FLX_CMD_SUFFIX=--json

# Override variables
FLY_SRC_APP?=?
FLY_SRC_FSPATH?=?FILEPATH?/$(FLY_SRC_NAME)
FLY_SRC_NAME?=?

## CMDS
FLY_CMD=cd $(FLY_SRC_FSPATH) && $(FLY_BIN_NAME)


## fly print, outputs all variables for the fly compiler
fly-print:
	@echo ""
	@echo "--- GO ---"
	@echo "FLY_GO_PATH:                $(FLY_GO_PATH)"
	@echo "FLY_GO_OS:                  $(FLY_GO_OS)"
	@echo "FLY_GO_ARCH:                $(FLY_GO_ARCH)"

	@echo ""
	@echo "--- FLY ---"
	@echo "FLY_BIN_NAME:               $(FLY_BIN_NAME)"
	@echo "FLY_BIN:                    $(FLY_BIN)"
	@echo "FLY_BIN_WINDOWS:            $(FLY_BIN_WINDOWS)"
	@echo "FLY_BIN_DARWIN:             $(FLY_BIN_DARWIN)"
	@echo "FLY_BIN_LINUX:              $(FLY_BIN_LINUX)"
	@echo ""
	@echo "--Override variables:"
	@echo "FLY_SRC_VERSION:           $(FLY_SRC_VERSION)"
	@echo "FLY_SRC_OUT_FSPATH:        $(FLY_SRC_OUT_FSPATH)"
	
	
	@echo "Binaries:"

	
	@echo ""
	@echo "-- Env variables:"
	@echo "FLY_CONFIG_FSPATH:             $(FLY_CONFIG_FSPATH)"
	@echo "FLY_ACCESS_TOKEN:              $(FLY_ACCESS_TOKEN)"  
	@echo "FLY_AUTH_TOKEN:                $(FLY_AUTH_TOKEN)"  
	
	@echo
	@echo Override variables:
	@echo "FLY_SRC_APP:                   $(FLY_SRC_APP)"
	@echo "FLY_SRC_FSPATH:                $(FLY_SRC_FSPATH)"
	@echo "FLY_SRC_NAME:                  $(FLY_SRC_NAME)"
	@echo
	@echo ""
	@echo "FLY_CMD:                       $(FLY_CMD)"
	

### Install

FLY_BIN_NAME=?
ifeq ($(FLY_GO_OS),windows)
	FLY_BIN_NAME=flyctl.exe
endif

ifeq ($(FLY_GO_OS),darwin)
	FLY_BIN_NAME=flyctl
endif

ifeq ($(FLY_GO_OS),linux)
	FLY_BIN_NAME=flyctl
endif 


fly-dep-pre:
	go install github.com/hashicorp/go-getter/cmd/go-getter@latest
fly-dep: fly-dep-pre

ifeq ($(FLY_GO_OS),windows)
	$(MAKE) fly-dep-windows
endif

ifeq ($(FLY_GO_OS),darwin)
	$(MAKE) fly-dep-darwin
endif

ifeq ($(FLY_GO_OS),linux)
	$(MAKE) fly-dep-linux
endif 


fly-dep-all: fly-dep-pre fly-dep-windows fly-dep-darwin fly-dep-linux

fly-dep-windows:
	go-getter $(FLY_DOWNLOAD_URL_PREFIX)/v$(FLY_SRC_VERSION)/flyctl_$(FLY_SRC_VERSION)_Windows_x86_64.zip $(FLY_BIN_WINDOWS)	
	chmod +x $(FLY_BIN_WINDOWS)/flyctl.exe

fly-dep-darwin:
	#  https://github.com/superfly/flyctl/releases/download/v0.1.56/flyctl_0.1.56_macOS_x86_64.tar.gz
	go-getter $(FLY_DOWNLOAD_URL_PREFIX)/v$(FLY_SRC_VERSION)/flyctl_$(FLY_SRC_VERSION)_macOS_x86_64.tar.gz $(FLY_BIN_DARWIN)
	chmod +x $(FLY_BIN_DARWIN)/flyctl
	
fly-dep-linux:
	go-getter $(FLY_DOWNLOAD_URL_PREFIX)/v$(FLY_SRC_VERSION)/flyctl_$(FLY_SRC_VERSION)_Linux_x86_64.tar.gz $(FLY_BIN_LINUX)
	chmod +x $(FLY_BIN_LINUX)/flyctl
	


### Delete

fly-dep-del:
	
ifeq ($(FFMPEG_GO_OS),windows)
	$(MAKE) fly-dep-del-windows
endif

ifeq ($(FFMPEG_GO_OS),darwin)
	$(MAKE) fly-dep-del-darwin
endif

ifeq ($(FFMPEG_GO_OS),linux)
	$(MAKE) fly-dep-del-linux
endif 

fly-dep-del-all: fly-dep-del-windows fly-dep-del-darwin fly-dep-del-linux
	
fly-dep-del-windows:
	rm -f $(FLY_BIN_WINDOWS)/flyctl.exe
	rm -f $(FLY_BIN_WINDOWS)/wintun.dll

fly-dep-del-darwin:
	rm -f $(FLY_BIN_DARWIN)/flyctl

fly-dep-del-linux:
	rm -f $(FLY_BIN_LINUX)/flyctl



fly-status-platform:
	# opens GUI.
	$(FLY_BIN_NAME) platform status

fly-status-platform-api:
	$(FLY_BIN_NAME) platform status $(FLX_CMD_SUFFIX)

fly-orgs:
	$(FLY_BIN_NAME) orgs list $(FLX_CMD_SUFFIX)


## CMDS

### FLY APP

fly-app-ls:
	$(FLY_CMD) apps list $(FLX_CMD_SUFFIX)
fly-app-console:
	open https://fly.io/apps/$(FLY_APP_NAME)
fly-app-destroy:
	$(FLY_CMD) apps destroy $(FLY_APP_NAME)



### SECRETS

fly-secrets-ls:
	$(FLY_CMD) secrets list
fly-secrets-ls-api:
	$(FLY_CMD) secrets list $(FLX_CMD_SUFFIX)
fly-secrets-import:
	# classic use: flyctl secrets import < .env
	$(FLY_CMD) secrets import
fly-secrets-set:
	$(FLY_CMD) secrets set $(NAME)=$(VALUE)
fly-secrets-unset:
	$(FLY_CMD) secrets unset NAME=$(NAME)

### REGIONS

fly-regions-platform:
	$(FLY_BIN_NAME) platform regions
fly-regions-platform-api:
	$(FLY_BIN_NAME) platform regions $(FLX_CMD_SUFFIX)
fly-regions-ls:
	$(FLY_CMD) regions list
fly-regions-ls-api:
	$(FLY_CMD) regions list $(FLX_CMD_SUFFIX)
fly-regions-add:
	# 3 spread is enough...
	# https://fly.io/docs/reference/regions/

	# Amsterdam, Netherlands
	$(FLY_CMD) regions add ams
	# Tokyo, Japan
	$(FLY_CMD) regions add nrt
	# Los Angeles, California (US)
	$(FLY_CMD) regions add lax

### VOLUMES

fly-vol-ls:
	$(FLY_CMD) volumes list
fly-vol-ls-api:
	$(FLY_CMD) volumes list $(FLX_CMD_SUFFIX)

fly-vol-create:
	# for single region, minimum 3 nodes required
	$(FLY_CMD) volumes create cdb_data --region ams --size 1
	$(FLY_CMD) volumes create cdb_data --region ams --size 1
	$(FLY_CMD) volumes create cdb_data --region ams --size 1
fly-vol-create-global:
	# for multi-region, minimum 3 regions required
fly-vol-del:
	$(FLY_CMD) volumes destroy vol_2gk9vwe0o51v76wm $(FLX_CMD_SUFFIX)

### SCALE


fly-scale-platform:
	$(FLY_CMD) platform vm-sizes
fly-scale-platform-api:
	$(FLY_CMD) platform vm-sizes $(FLX_CMD_SUFFIX)
fly-scale-ls:
	$(FLY_CMD) scale show
fly-scale-ls-api:
	$(FLY_CMD) scale show $(FLX_CMD_SUFFIX)
FLY_SCALE_CORES=1
FLY_SCALE_MEM=256
fly-scale-create:
	# Set VM size and scale to desired node count
	# To create dedicated VMs please contact billing@fly.io
	$(FLY_CMD) scale vm $(FLY_SCALE_CORES) --memory $(FLY_SCALE_MEM)

### DEPLOY

fly-deploy:
	# needs colima
	$(FLY_CMD) deploy --remote-only 

fly-deploy-api:
	$(FLY_CMD) deploy $(FLX_CMD_SUFFIX)

### SSH

fly-ssh:
	$(FLY_CMD) ssh console -C '/cockroach/init_cluster.sh'



