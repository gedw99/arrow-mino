# CADDY
# github.com/caddyserver/caddy

# XCADDY
# https://github.com/caddyserver/xcaddy

# MKCERT
# https://github.com/FiloSottile/mkcert

# HOSTCTL
# https://github.com/guumaster/hostctl
# works on Linux, Mac and Windows :)

CADDY_BIN_NAME=caddy
# https://github.com/caddyserver/caddy/releases/tag/v2.6.4
# https://github.com/caddyserver/caddy/releases/tag/v2.7.0-beta.2
CADDY_BIN_VERSION=v2.6.4
CADDY_BIN_WHICH=$(shell which $(CADDY_BIN_NAME))
CADDY_BIN_WHICH_VERSION=$(shell $(CADDY_BIN_NAME) version)

CADDY_XCADDY_BIN_NAME=xcaddy
# https://github.com/caddyserver/xcaddy/releases/tag/v0.3.4
CADDY_XCADDY_BIN_VERSION=v0.3.4
CADDY_XCADDY_BIN_WHICH=$(shell which $(CADDY_XCADDY_BIN_NAME))
CADDY_XCADDY_BIN_WHICH_VERSION=$(shell $(CADDY_XCADDY_BIN_NAME) version)

CADDY_MKCERT_BIN_NAME=mkcert
# https://github.com/FiloSottile/mkcert/releases/tag/v1.4.4
CADDY_MKCERT_BIN_VERSION=v1.4.4
CADDY_MKCERT_BIN_WHICH=$(shell which $(CADDY_MKCERT_BIN_NAME))
CADDY_MKCERT_BIN_WHICH_VERSION=$(shell $(CADDY_MKCERT_BIN_NAME) --version)

# https://github.com/kevinburke/hostsfile
CADDY_HOSTSFILE_BIN_NAME=hostsfile
CADDY_HOSTSFILE_BIN_VERSION=latest
CADDY_HOSTSFILE_BIN_WHICH=$(shell which $(CADDY_HOSTSFILE_BIN_NAME))
CADDY_HOSTSFILE_BIN_WHICH_VERSION=$(shell $(CADDY_HOSTSFILE_BIN_NAME) version)

# https://github.com/guumaster/hostctl
CADDY_HOSTSCTL_BIN_NAME=hostctl
CADDY_HOSTSCTL_BIN_VERSION=v1.1.3
CADDY_HOSTSCTL_BIN_WHICH=$(shell which $(CADDY_HOSTSCTL_BIN_NAME))
CADDY_HOSTSCTL_BIN_WHICH_VERSION=$(shell $(CADDY_HOSTSCTL_BIN_NAME) --version)


# Override variables

# where to look for CaddyFile to use at runtime 
CADDY_SRC_FSPATH=$(PWD)
CADDY_SRC_CONFIG_NAME=Caddyfile

# defaults for simple setup
CADDY_SRC_DOMAIN=localhost
CADDY_SRC_SUBDOMAINS=

# More advanced setup not finished yet
# CADDY_SRC_DOMAIN=localhost.site
# CADDY_SRC_SUBDOMAINS=localhost.$(CADDY_SRC_DOMAIN) www.$(CADDY_SRC_DOMAIN) sub1.$(CADDY_SRC_DOMAIN) 127.0.0.1


# Computed variables
# PERFECT :) https://www.systutorials.com/how-to-get-a-makefiles-directory-for-including-other-makefiles/
_CADDY_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
_CADDY_TEMPLATES_SOURCE=$(_CADDY_SELF_DIR)templates/caddy
_CADDY_TEMPLATES_TARGET=$(PWD)/.templates/caddy



## caddy print, outputs all variables needed to run caddy
caddy-print:
	@echo ""
	@echo "--- CADDY ---"

	@echo "Deps:"
	@echo "CADDY_BIN_NAME:                    $(CADDY_BIN_NAME)"
	@echo "CADDY_BIN_VERSION:                 $(CADDY_BIN_VERSION)"
	@echo "CADDY_BIN_WHICH:                   $(CADDY_BIN_WHICH)"
	@echo "CADDY_BIN_WHICH_VERSION:           $(CADDY_BIN_WHICH_VERSION)"      


	@echo ""
	@echo "CADDY_XCADDY_BIN_NAME:             $(CADDY_XCADDY_BIN_NAME)"
	@echo "CADDY_XCADDY_BIN_VERSION:          $(CADDY_XCADDY_BIN_VERSION)"
	@echo "CADDY_XCADDY_BIN_WHICH:            $(CADDY_XCADDY_BIN_WHICH)"
	@echo "CADDY_XCADDY_BIN_WHICH_VERSION:    $(CADDY_XCADDY_BIN_WHICH_VERSION)"

	@echo ""
	@echo "CADDY_MKCERT_BIN_NAME:             $(CADDY_MKCERT_BIN_NAME)"
	@echo "CADDY_MKCERT_BIN_VERSION:          $(CADDY_MKCERT_BIN_VERSION)"
	@echo "CADDY_MKCERT_BIN_WHICH:            $(CADDY_MKCERT_BIN_WHICH)"
	@echo "CADDY_MKCERT_BIN_WHICH_VERSION:    $(CADDY_MKCERT_BIN_WHICH_VERSION)"

	@echo ""
	@echo "CADDY_HOSTSFILE_BIN_NAME:          $(CADDY_HOSTSFILE_BIN_NAME)"
	@echo "CADDY_HOSTSFILE_BIN_VERSION:       $(CADDY_HOSTSFILE_BIN_VERSION)"
	@echo "CADDY_HOSTSFILE_BIN_WHICH:         $(CADDY_HOSTSFILE_BIN_WHICH)"
	@echo "CADDY_HOSTSFILE_BIN_WHICH_VERSION: $(CADDY_HOSTSFILE_BIN_WHICH_VERSION)"

	@echo ""
	@echo "CADDY_HOSTSCTL_BIN_NAME:           $(CADDY_HOSTSCTL_BIN_NAME)"
	@echo "CADDY_HOSTSCTL_BIN_VERSION:        $(CADDY_HOSTSCTL_BIN_VERSION)"
	@echo "CADDY_HOSTSCTL_BIN_WHICH:          $(CADDY_HOSTSCTL_BIN_WHICH)"
	@echo "CADDY_HOSTSCTL_BIN_WHICH_VERSION:  $(CADDY_HOSTSCTL_BIN_WHICH_VERSION)"

	@echo ""
	@echo "Override variables:"
	@echo "CADDY_SRC_FSPATH:                  $(CADDY_SRC_FSPATH)"
	@echo "CADDY_SRC_CONFIG_NAME:             $(CADDY_SRC_CONFIG_NAME)"
	@echo "CADDY_SRC_DOMAIN:                  $(CADDY_SRC_DOMAIN)"
	@echo "CADDY_SRC_SUBDOMAINS:              $(CADDY_SRC_SUBDOMAINS)"
	


## caddy dep installs the caddy and mkcert binary to the go bin
## cand copies the templates up into your templates working directory
# Useful where you want to grab them and customise.

## installs caddy
caddy-dep:

	@echo
	@echo installing caddy tool
	go install -ldflags="-X main.version=$(CADDY_BIN_VERSION)" github.com/caddyserver/caddy/v2/cmd/caddy@$(CADDY_BIN_VERSION)
	@echo installed $(CADDY_BIN_VERSION) at :                      $(CADDY_BIN_WHICH)

	@echo
	@echo installing xcaddy tool
	go install -ldflags="-X main.version=$(CADDY_XCADDY_BIN_VERSION)" github.com/caddyserver/xcaddy/cmd/xcaddy@$(CADDY_XCADDY_BIN_VERSION)
	@echo installed $(CADDY_XCADDY_BIN_VERSION) at :               $(CADDY_XCADDY_BIN_WHICH)

	@echo
	@echo installing mkcert tool
	go install -ldflags="-X main.version=$(CADDY_MKCERT_BIN_VERSION)" filippo.io/mkcert@$(CADDY_MKCERT_BIN_VERSION)
	@echo installed $(CADDY_MKCERT_BIN_VERSION) at :    $(CADDY_MKCERT_BIN_WHICH)

	@echo
	@echo installing hostsfile tool
	# https://github.com/kevinburke/hostsfile
	go install -ldflags="-X main.version=$(CADDY_HOSTSFILE_BIN_VERSION)" github.com/kevinburke/hostsfile@$(CADDY_HOSTSFILE_BIN_VERSION)
	@echo installed $(CADDY_HOSTSFILE_BIN_VERSION) at : $(CADDY_HOSTSFILE_BIN_WHICH)

	@echo
	#https://github.com/guumaster/hostctl
	@echo installing hostsctl tool
	go install -ldflags="-X main.version=$(CADDY_HOSTSCTL_BIN_VERSION)" github.com/guumaster/hostctl/cmd/hostctl@$(CADDY_HOSTSCTL_BIN_VERSION)
	@echo installed hostctl [ $(CADDY_HOSTSCTL_BIN_VERSION) ] at : $(CADDY_HOSTSCTL_BIN_WHICH)

### TEMPLATES

## prints the templates 
caddy-templates-print:
	@echo ""
	@echo "- templates:"
	@echo "_CADDY_SELF_DIR:                   $(_CADDY_SELF_DIR)"
	@echo "_CADDY_TEMPLATES_SOURCE:           $(_CADDY_TEMPLATES_SOURCE)"
	@echo "_CADDY_TEMPLATES_TARGET:           $(_CADDY_TEMPLATES_TARGET)"
	
caddy-templates-ls:
	@echo ""
	@echo "listing templates ...""
	cd $(_CADDY_TEMPLATES_SOURCE) && ls -al

## installs the caddy templates into your project
caddy-templates-dep:
	@echo
	@echo installing caddy templates to your project....
	mkdir -p $(_CADDY_TEMPLATES_TARGET)
	cp -r $(_CADDY_TEMPLATES_SOURCE)/* $(_CADDY_TEMPLATES_TARGET)
	@echo installed caddy templates  at : $(_CADDY_TEMPLATES_TARGET)


## caddy mkcert installs the certs for browsers to run localhost
caddy-mkcert-run:
	@echo
	@echo installing mkcert certs
	cd $(CADDY_SRC_FSPATH) && $(CADDY_MKCERT_BIN_NAME) -install

	cd $(CADDY_SRC_FSPATH) && $(CADDY_MKCERT_BIN_NAME) $(CADDY_SRC_DOMAIN)

	# TODO finsihed compelx setup..
	# https://www.derpytools.com/how-to-set-up-custom-domain-https-http-3-locally-using-hostsfile-mkcert-caddy/
	# mkcert derpycoder derpycoder.site "*.derpycoder.site" localhost 127.0.0.1 ::1
	#cd $(CADDY_SRC_FSPATH) && $(CADDY_MKCERT_BIN_NAME) $(CADDY_SRC_DOMAIN) "$(CADDY_SRC_DOMAIN)" localhost 127.0.0.1 ::1
	@echo installed mkcert certs at : $(CADDY_SRC_FSPATH)

## mutates hostfile
caddy-hostsfile-run:
	# sudo $(CADDY_HOSTSFILE_BIN_NAME) add derpycoder.site www.derpycoder.site blog.derpycoder.site analytics.derpycoder.site 127.0.0.1
	sudo $(CADDY_HOSTSFILE_BIN_NAME) add $(CADDY_SRC_DOMAIN) $(CADDY_SRC_SUBDOMAINS)

## opens hostfile for checking.
caddy-hostsfile-open:
	code /etc/hosts

## viws hostfile on stdout terminal.
caddy-hostsfile-view:
	cat /etc/hosts

## caddy fmt runs fixes your caddy file.
caddy-fmt:
	cd $(CADDY_SRC_FSPATH) && $(CADDY_BIN_NAME) fmt --overwrite

## caddy without a config for quick stuff
caddy-server-run-browse:
	cd $(CADDY_SRC_FSPATH) && $(CADDY_BIN_NAME) file-server --browse

## caddy run runs caddy using your Caddyfile. 
caddy-server-run: caddy-mkcert-run
	cd $(CADDY_SRC_FSPATH) && $(CADDY_BIN_NAME) run --config $(CADDY_SRC_CONFIG_NAME)

	# --environ --resume. DONT use this
	#  --config and --resume flags were used together; ignoring --config and resuming from last configuration  {"autosave_file": "/Users/apple/Library/Application Support/Caddy/autosave.json"}
	#cd $(CADDY_SRC_FSPATH) && $(CADDY_BIN_NAME) run --environ --resume --config $(CADDY_SRC_CONFIG_NAME)
	
	# open https://localhost:8443

## caddy run and watch for config changes	
caddy-server-run-watch:
	cd $(CADDY_SRC_FSPATH) && $(CADDY_BIN_NAME) run --config $(CADDY_SRC_CONFIG_NAME) --watch


