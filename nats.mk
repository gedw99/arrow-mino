# NATS BOX ( https://github.com/nats-io/nats-box) 
# has many of these tools with correct version matrix


# NATS-SERVER
# https://github.com/nats-io/nats-server
# https://github.com/nats-io/nats-server/releases/tag/v2.9.14
# https://github.com/nats-io/nats-server/releases/tag/v2.9.17
NATS_SERVER_BIN_NAME=nats-server
NATS_SERVER_BIN_VERSION=v2.9.14
#NATS_SERVER_BIN_VERSION=latest
NATS_SERVER_BIN_WHICH=$(shell which $(NATS_SERVER_BIN_NAME))
NATS_SERVER_BIN_WHICH_VERSION=$(shell $(NATS_SERVER_BIN_WHICH) --version)

# NATS
# https://github.com/nats-io/natscli
# https://github.com/nats-io/natscli/releases/tag/v0.0.35
NATS_CLI_BIN_NAME=nats
NATS_CLI_BIN_VERSION=v0.0.35
#NATS_CLI_BIN_VERSION=latest
NATS_CLI_BIN_WHICH=$(shell which $(NATS_CLI_BIN_NAME))
NATS_CLI_BIN_WHICH_VERSION=$(shell $(NATS_CLI_BIN_WHICH) --version)

# NSC
# https://github.com/nats-io/nsc
# docs: https://docs.nats.io/using-nats/nats-tools/nsc/basics
# https://github.com/nats-io/nsc/releases/tag/v2.8.0
NATS_NSC_BIN_NAME=nsc
NATS_NSC_BIN_VERSION=v2.8.0
#NATS_NSC_BIN_VERSION=latest
NATS_NSC_BIN_WHICH=$(shell which $(NATS_NSC_BIN_NAME))
NATS_NSC_BIN_WHICH_VERSION=$(shell $(NATS_NSC_BIN_WHICH) --version)

# NK
# https://github.com/nats-io/nkeys
# https://github.com/nats-io/nkeys/releases/tag/v0.3.0
# https://github.com/nats-io/nkeys/releases/tag/v0.4.4
NATS_NK_BIN_NAME=nk
NATS_NK_BIN_VERSION=v0.4.4
#NATS_NK_BIN_VERSION=latest
NATS_NK_BIN_WHICH=$(shell which $(NATS_NK_BIN_NAME))
NATS_NK_BIN_WHICH_VERSION=
# comments out because too much shit back ...
#NATS_NK_BIN_WHICH_VERSION=$(shell $(NATS_NK_BIN_WHICH) --version)

# NATS_TOP
# https://github.com/nats-io/nats-top
# https://github.com/nats-io/nats-top/releases/tag/v0.5.3
NATS_TOP_BIN_NAME=nats-top
NATS_TOP_BIN_VERSION=v0.6.0
NATS_TOP_BIN_VERSION=latest
NATS_TOP_BIN_WHICH=$(shell which $(NATS_TOP_BIN_NAME))
NATS_TOP_BIN_WHICH_VERSION=$(shell $(NATS_TOP_BIN_WHICH) --version)








## nats print, outputs all variables needed to run nats
nats-print:
	@echo ""
	@echo "--- NATS ---"

	@echo "Deps:"
	@echo "NATS_SERVER_BIN_NAME:             $(NATS_SERVER_BIN_NAME)"
	@echo "NATS_SERVER_BIN_VERSION:          $(NATS_SERVER_BIN_VERSION)"
	@echo "NATS_SERVER_BIN_WHICH:            $(NATS_SERVER_BIN_WHICH)"
	@echo "NATS_SERVER_BIN_WHICH_VERSION:    $(NATS_SERVER_BIN_WHICH_VERSION)"
	
	@echo ""
	@echo "NATS_CLI_BIN_NAME:                $(NATS_CLI_BIN_NAME)"
	@echo "NATS_CLI_BIN_VERSION:             $(NATS_CLI_BIN_VERSION)"
	@echo "NATS_CLI_BIN_WHICH:               $(NATS_CLI_BIN_WHICH)"
	@echo "NATS_CLI_BIN_WHICH_VERSION:       $(NATS_CLI_BIN_WHICH_VERSION)"

	@echo ""
	@echo "NATS_NSC_BIN_NAME:                $(NATS_NSC_BIN_NAME)"
	@echo "NATS_NSC_BIN_VERSION:             $(NATS_NSC_BIN_VERSION)"
	@echo "NATS_NSC_BIN_WHICH:               $(NATS_NSC_BIN_WHICH)"
	@echo "NATS_NSC_BIN_WHICH_VERSION:       $(NATS_NSC_BIN_WHICH_VERSION)"
	
	@echo ""
	@echo "NATS_NK_BIN_NAME:                 $(NATS_NK_BIN_NAME)"
	@echo "NATS_NK_BIN_VERSION:              $(NATS_NK_BIN_VERSION)"
	@echo "NATS_NK_BIN_WHICH:                $(NATS_NK_BIN_WHICH)"
	@echo "NATS_NK_BIN_WHICH_VERSION:        $(NATS_NK_BIN_WHICH_VERSION)"
	
	@echo ""
	@echo "NATS_TOP_BIN_NAME:                $(NATS_TOP_BIN_NAME)"
	@echo "NATS_TOP_BIN_VERSION:             $(NATS_TOP_BIN_VERSION)"
	@echo "NATS_TOP_BIN_WHICH:               $(NATS_TOP_BIN_WHICH)"
	@echo "NATS_TOP_BIN_WHICH_VERSION:       $(NATS_TOP_BIN_WHICH_VERSION)"

	
	


## installs nats
nats-dep:
	@echo ""
	@echo "installing NATS server"
	go install -ldflags="-X main.version=$(NATS_SERVER_BIN_VERSION)" github.com/nats-io/nats-server/v2@$(NATS_SERVER_BIN_VERSION)
	@echo "installed $(NATS_SERVER_BIN_WHICH)"

	@echo ""
	@echo "installing NATS cli tool"
	go install -ldflags="-X main.version=$(NATS_CLI_BIN_VERSION)" github.com/nats-io/natscli/nats@$(NATS_CLI_BIN_VERSION)
	@echo "installed $(NATS_CLI_BIN_WHICH)"

	@echo ""
	@echo "installing NATS nsc tool"
	go install -ldflags="-X main.version=$(NATS_NSC_BIN_VERSION)" github.com/nats-io/nsc/v2@$(NATS_NSC_BIN_VERSION)
	@echo "installed $(NATS_NSC_BIN_WHICH)"

	@echo ""
	@echo "installing NATS nk tool"
	go install -ldflags="-X main.version=$(NATS_NK_BIN_VERSION)" github.com/nats-io/nkeys/nk@$(NATS_NK_BIN_VERSION)
	@echo "installed $(NATS_NK_BIN_NAME)"

	@echo ""
	@echo "installing NATS top tool"
	go install -ldflags="-X main.version=$(NATS_TOP_BIN_VERSION)" github.com/nats-io/nats-top@$(NATS_TOP_BIN_VERSION)
	@echo "installed $(NATS_TOP_BIN_WHICH)"



### TEMPLATES

_NATS_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
NATS_SRC_TEMPLATES_FSPATH=$(PWD)/.templates/nats
_NATS_TEMPLATES_SOURCE=$(_NATS_SELF_DIR)/templates/nats
_NATS_TEMPLATES_TARGET=$(NATS_SRC_TEMPLATES_FSPATH)

nats-templates-print:
	@echo ""
	@echo "-- TEMPLATES --"
	@echo "_NATS_SELF_DIR:                   $(_NATS_SELF_DIR)"
	@echo "_NATS_TEMPLATES_SOURCE:           $(_NATS_TEMPLATES_SOURCE)"
	@echo "_NATS_TEMPLATES_TARGET:           $(_NATS_TEMPLATES_TARGET)"
	@echo ""

## installs the nats templates into your project
nats-templates-dep:
	@echo ""
	@echo "installing nats templates to your project...."
	mkdir -p $(_NATS_TEMPLATES_TARGET)
	cp -r $(_NATS_TEMPLATES_SOURCE)/* $(_NATS_TEMPLATES_TARGET)/
	@echo "installed nats templates  at : $(_NATS_TEMPLATES_TARGET)"
nats-templates-dep-del:
	rm -rf $(_NATS_TEMPLATES_TARGET)


### ENV ###


# where to look for Nats Config file to use at runtime 
NATS_ENV_CONFIG_NAME=natsfile
NATS_ENV_NSC_DATA_FSPATH=$(PWD)/.data/nats/nsc

nats-env-print:
	@echo ""
	@echo "-- ENV --"
	@echo "NATS_ENV_NSC_DATA_FSPATH:         $(NATS_ENV_NSC_DATA_FSPATH)"
	@echo "NATS_ENV_CONFIG_NAME:             $(NATS_ENV_CONFIG_NAME)"
	@echo ""

### NSC

# --config-dir
# --data-dir
# --keystore-dir

NATS_NSC_CMD=$(NATS_NSC_BIN_NAME) --all-dirs $(NATS_ENV_NSC_DATA_FSPATH) 

## nats mkcert installs the certs for browsers to run localhost


nats-nsc-init:
	$(NATS_NSC_CMD) init
	# sets an operator: i use gedw99
nats-nsc-init-del:
	rm -rf $(NATS_ENV_NSC_DATA_FSPATH) 

nats-nsc-update:
	$(NATS_NSC_CMD) update --interactive

nats-nsc-gen:
	#$(NATS_NSC_CMD) generate activation -h

	# this generates a nats server config.
	#$(NATS_NSC_CMD) generate config --mem-resolver --config-file <path/server.conf>

	#$(NATS_NSC_CMD) generate creds -h

	$(NATS_NSC_CMD) generate diagram --output-file $(PWD)/nats-nsc-dia-component.uml component
	$(NATS_NSC_CMD) generate diagram --output-file $(PWD)/nats.nsc-dia-object.uml object

nats-nsc-list:
	@echo ""
	@echo "-- operators"
	$(NATS_NSC_CMD) list operators

	@echo ""
	@echo "-- accounts"
	$(NATS_NSC_CMD) list accounts

	@echo ""
	@echo "-- keys"
	$(NATS_NSC_CMD) list keys

	@echo ""
	@echo "-- users"
	$(NATS_NSC_CMD) list users

	@echo ""
	@echo "-- users by accunt or operator"
	$(NATS_NSC_CMD) list users --account gedw99
	$(NATS_NSC_CMD) list users --operator gedw99

nats-nsc-add-operator:
	$(NATS_NSC_CMD) add operator MyOperator

NATS_ACCOUNT_NAME=HR

nats-nsc-list-account:
	$(NATS_NSC_CMD) list accounts
nats-nsc-add-account:
	$(NATS_NSC_CMD) add account --name $(NATS_ACCOUNT_NAME)
nats-nsc-edit-account:
	$(NATS_NSC_CMD) edit account --name $(NATS_ACCOUNT_NAME) --js-mem-storage 1G --js-disk-storage 512M  --js-streams 10 --js-consumer 100
nats-nsc-del-account:
	$(NATS_NSC_CMD) delete account --name $(NATS_ACCOUNT_NAME)
nats-nsc-del-account-all:
	$(NATS_NSC_CMD) delete account -h



### SERVER

## nats run runs nats using your nats Config
nats-server-run:
	# https://docs.nats.io/running-a-nats-service/introduction/running#jetstream
	# Use conf
	$(NATS_SERVER_BIN_NAME) -c $(NATS_ENV_CONFIG_NAME)


### MONITORING

nats-mon-open:
	open http://localhost:8222/
nats-mon-test:
	curl http://localhost:8222/varz




