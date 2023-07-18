# OVERMIND
# https://github.com/DarthSim/overmind

# does NOT work on linux

OVERMIND_BIN_NAME=overmind
# https://github.com/DarthSim/overmind/releases/tag/v2.4.0
OVERMIND_BIN_VERSION=v2.4.0
OVERMIND_BIN_WHICH=$(shell which $(OVERMIND_BIN_NAME))
OVERMIND_BIN_WHICH_VERSION=$(shell $(OVERMIND_BIN_NAME) -v)

# Override variables
# where to put the standard templates
OVERMIND_SRC_TEMPLATES_FSPATH=$(PWD)/.templates/overmind
# where to look for Proc to use at runtime
OVERMIND_SRC_FSPATH=$(PWD)/

# Computed variables
# PERFECT :) https://www.systutorials.com/how-to-get-a-makefiles-directory-for-including-other-makefiles/
_OVERMIND_SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
_OVERMIND_TEMPLATES_SOURCE=$(_OVERMIND_SELF_DIR)/templates/overmind
_OVERMIND_TEMPLATES_TARGET=$(OVERMIND_SRC_TEMPLATES_FSPATH)



## overmind print, outputs all variables needed to run overmind
overmind-print:
	@echo ""
	@echo "--- OVERMIND ---"

	@echo "Deps:"
	@echo "OVERMIND_BIN_NAME:              $(OVERMIND_BIN_NAME)"
	@echo "OVERMIND_BIN_VERSION:           $(OVERMIND_BIN_VERSION)"
	@echo "OVERMIND_BIN_WHICH:             $(OVERMIND_BIN_WHICH)"
	@echo "OVERMIND_BIN_WHICH_VERSION:     $(OVERMIND_BIN_WHICH_VERSION)"

	@echo ""
	@echo "Override variables:"
	@echo "OVERMIND_SRC_FSPATH:            $(OVERMIND_SRC_FSPATH)"
	
	@echo ""
	@echo "Computed variables:"
	@echo "_OVERMIND_SELF_DIR:             $(_OVERMIND_SELF_DIR)"
	@echo "_OVERMIND_TEMPLATES_SOURCE:     $(_OVERMIND_TEMPLATES_SOURCE)"
	@echo "_OVERMIND_TEMPLATES_TARGET:     $(_OVERMIND_TEMPLATES_TARGET)"
	@echo ""


## installs overmind
overmind-dep:

	# check if there already.
ifeq ($(OVERMIND_BIN_WHICH), nil)
	@echo overmind exists
endif 


	@echo
	@echo installing overmind
	go install -ldflags="-X main.version=$(OVERMIND_BIN_VERSION)" github.com/DarthSim/overmind/v2@$(OVERMIND_BIN_VERSION)
	@echo installed $(OVERMIND_BIN_VERSION)

	#$(MAKE) overmind-templates-dep

overmind-dep-del:
	@echo
	@echo deleting overmind
	rm -f $(OVERMIND_BIN_WHICH)

## installs the overmind templates into your project
overmind-templates-dep:
	@echo
	@echo installing overmind templates to your project....
	mkdir -p $(_OVERMIND_TEMPLATES_TARGET)
	cp -r $(_OVERMIND_TEMPLATES_SOURCE)/* $(_OVERMIND_TEMPLATES_TARGET)/
	@echo installed overmind templates  at : $(_OVERMIND_TEMPLATES_TARGET)


## overmind run runs overmind using your Procfile
overmind-run:
	# https://github.com/DarthSim/overmind#scaling-processes-formation
	cd $(OVERMIND_SRC_FSPATH) && $(OVERMIND_BIN_NAME) start



### OPS

# these are the standard ops for overmind to allow daemonisation, which you need for production.
# Later: we need to expose these to to the bus so that they can be called easily. 
# thats why we call them ops !!
# For now the make file calls them to just get going and used to usng overmind.

# https://github.com/DarthSim/overmind#overmind-environment

# https://github.com/jtarchie/forum is a great fly and overmind example. Its clever approahc

OVERMIND_OPS_ANY_CAN_DIE=1
OVERMIND_OPS_SHOW_TIMESTAMPS=1

## start as daemon
overmind-daemon-ops-start:
	# start uo
	# https://github.com/DarthSim/overmind#run-as-a-daemon
	$(MAKE) OVERMIND_DAEMONIZE=1 OVERMIND_ANY_CAN_DIE=$(OVERMIND_OPS_ANY_CAN_DIE) OVERMIND_SHOW_TIMESTAMPS=$(OVERMIND_OPS_SHOW_TIMESTAMPS) overmind-run

## send back the logs
overmind-daemon-ops-logs:
	# echo back the daemons logs
	$(OVERMIND_BIN_NAME) echo
## quit the daemon
overmind-daemon-ops-quit:
	# kill daemon
	$(OVERMIND_BIN_NAME) quit



OVERMIND_OPS_CONNECT_NAME=?
## connect to a process. Set the OVERMIND_OPS_CONNECT_NAME variable for what process you ant to connect to.
overmind-ops-connect:
	# https://github.com/DarthSim/overmind#connecting-to-a-process
	$(OVERMIND_BIN_NAME) connect $(OVERMIND_OPS_CONNECT_NAME)

# restart all processes
overmind-ops-restart:
	# https://github.com/DarthSim/overmind#restarting-a-process
	$(OVERMIND_BIN_NAME) restart

OVERMIND_OPS_RESTART_NAME=?
# restart named processes. Set OVERMIND_OPS_RESTART_NAME variable.
overmind-ops-restart-named:
	# https://github.com/DarthSim/overmind#restarting-a-process
	$(OVERMIND_BIN_NAME) restart $(OVERMIND_OPS_RESTART_NAME)

## stop all processes
overmind-ops-stop:
	# https://github.com/DarthSim/overmind#stopping-a-process
	$(OVERMIND_BIN_NAME) stop

	


