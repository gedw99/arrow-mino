# https://github.com/hetznercloud/cli

# https://status.hetzner.com/

# k3: https://github.com/duncanpierce/hetzanetes

#  https://github.com/hetznercloud/cli/blob/main/gon.hcl
# yeah !!

HCLOUD_BIN_NAME=hcloud
HCLOUD_BIN_VERSION=latest
HCLOUD_BIN_WHICH=$(shell which $(HCLOUD_BIN_NAME))
HCLOUD_BIN_WHICH_VERSION=$(shell $(HCLOUD_BIN_NAME) version)

# env in $HOME/.zsh

HCLOUD_CONTEXT?=

HCLOUD_CONFIG?=

# code
HCLOUD_SRC_FSPATH?=?
HCLOUD_SRC_NAME?=?

# envs
# ssh
HCLOUD_SRC_SSH_KEY_NAME=gedw99
HCLOUD_SRC_SSH_KEY_FILE=~/.ssh/gedw99_github.com.pub
# server
HCLOUD_SRC_DATACENTER_NAME=nbg1-dc3
HCLOUD_SRC_SERVER_TYPE=cx11
HCLOUD_SRC_SERVER_NAME=default

hcloud-print:
	@echo ""
	@echo Deps:
	@echo --- GO ---
	@echo "HCLOUD_GO_BIN_NAME:                 $(HCLOUD_GO_BIN_NAME)"

	@echo --- HCLOUD ---
	@echo "HCLOUD_BIN_NAME:                    $(HCLOUD_BIN_NAME)"
	@echo "HCLOUD_BIN_VERSION:                 $(HCLOUD_BIN_VERSION)"
	@echo "HCLOUD_BIN_WHICH:                   $(HCLOUD_BIN_WHICH)"
	@echo "HCLOUD_BIN_WHICH_VERSION:           $(HCLOUD_BIN_WHICH_VERSION)"
	@echo ""
	@echo "- env variables:"
	@echo "HCLOUD_TOKEN:                       $(HCLOUD_TOKEN)"
	@echo "HCLOUD_API_TOKEN:                   $(HCLOUD_API_TOKEN)"
	
	@echo "HCLOUD_CONTEXT:                     $(HCLOUD_CONTEXT)"
	@echo "HCLOUD_CONFIG:                      $(HCLOUD_CONFIG)"
	@echo ""
	@echo "- Override variables:"
	@echo "HCLOUD_SRC_FSPATH:                  $(HCLOUD_SRC_FSPATH)"
	@echo "HCLOUD_SRC_NAME:                    $(HCLOUD_SRC_NAME)"
	@echo "HCLOUD_SRC_DATACENTER_NAME:         $(HCLOUD_SRC_DATACENTER_NAME)"
	@echo "HCLOUD_SRC_SERVER_TYPE:             $(HCLOUD_SRC_SERVER_TYPE)"
	@echo "HCLOUD_SRC_SERVER_NAME:             $(HCLOUD_SRC_SERVER_NAME)"


hcloud-dep:
	go install github.com/hetznercloud/cli/cmd/hcloud@$(HCLOUD_BIN_VERSION)
	#brew install hcloud

hcloud-auth:
	open https://console.hetzner.cloud/
	# ebSrTWufAiFC@43

### SERVERS

hcloud-server-ls:
	$(HCLOUD_BIN_NAME) server list

HCLOUD_SERVER_NAME?=	
hcloud-server-describe:
	# make hcloud-server-describe HCLOUD_SERVER_NAME=ccx22
	$(HCLOUD_BIN_NAME) server describe $(HCLOUD_SERVER_NAME)

hcloud-server-type-ls:
	$(HCLOUD_BIN_NAME) server-type list

HCLOUD_SRC_SERVER_TYPE?=	
hcloud-server-type-describe:
	# pricing here ...
	#$(HCLOUD_BIN_NAME) server-type describe cax11
	# make hcloud-server-type-describe HCLOUD_SRC_SERVER_TYPE=ccx22
	$(HCLOUD_BIN_NAME) server-type describe $(HCLOUD_SRC_SERVER_TYPE)

hcloud-server-create:
	# pmp ssh pb key up.
	$(HCLOUD_BIN_NAME) ssh-key create --name $(HCLOUD_SRC_SSH_KEY_NAME) --public-key-from-file $(HCLOUD_SRC_SSH_KEY_FILE)

	# hcloud server create --name test --image debian-9 --type cx11 --ssh-key $(HCLOUD_SRC_SSH_KEY_NAME)
	$(HCLOUD_BIN_NAME) server create --name $(HCLOUD_SRC_SERVER_NAME) --image debian-9 --type $(HCLOUD_SRC_SERVER_TYPE) --ssh-key demo

hcloud-server-del:
	# hcloud server delete --name test
	$(HCLOUD_BIN_NAME) server delete --name $(HCLOUD_SRC_SERVER_NAME)


### REGIONS
hcloud-region-ls:
	$(HCLOUD_BIN_NAME) location list
hcloud-region-descrbe:
	#$(HCLOUD_BIN_NAME) location describe fsn1
	$(HCLOUD_BIN_NAME) location describe nbg1
	#$(HCLOUD_BIN_NAME) location describe hel1
	#$(HCLOUD_BIN_NAME) location describe ash
	#$(HCLOUD_BIN_NAME) location describe hil

### DATA CENTERS
hcloud-dc-ls:
	$(HCLOUD_BIN_NAME) datacenter list
hcloud-dc-descrbe:
	$(HCLOUD_BIN_NAME) datacenter describe nbg1-dc3

hcloud-context:
	# DONT use htis. JUst use make config
	$(HCLOUD_BIN_NAME) context create $(HCLOUD_SRC_NAME)