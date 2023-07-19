
# Needs binary called "gonew", from "make go-dep"


# weaver support for autoscale on k8
# template: https://github.com/ServiceWeaver/template/
# examples: https://github.com/ServiceWeaver/workshops
# docs: https://serviceweaver.dev/docs.html


# https://github.com/ServiceWeaver/weaver/tags
# https://github.com/ServiceWeaver/weaver/releases/tag/v0.17.0
WEAVER_BIN_NAME=weaver
WEAVER_BIN_VER=v0.17.0
WEAVER_BIN_WHICH=$(shell which $(WEAVER_BIN_NAME))
WEAVER_BIN_WHICH_VERSION=$(shell $(WEAVER_BIN_NAME) version)
WEAVER_BIN_WHICH_GO_VERSION=$(shell go version $(WEAVER_BIN_WHICH))

# https://github.com/ServiceWeaver/weaver-gke/tags
# https://github.com/ServiceWeaver/weaver-gke/releases/tag/v0.15.0
WEAVER_GKE_BIN_NAME=weaver-gke
WEAVER_GKE_BIN_VER=v0.15.0
WEAVER_GKE_BIN_WHICH=$(shell which $(WEAVER_GKE_BIN_NAME))
WEAVER_GKE_BIN_WHICH_VERSION=$(shell $(WEAVER_GKE_BIN_NAME) version)
WEAVER_GKE_BIN_WHICH_GO_VERSION=$(shell go version $(WEAVER_GKE_BIN_WHICH))

# https://github.com/ServiceWeaver/weaver-kube
# https://github.com/ServiceWeaver/weaver-kube/tags
# https://github.com/ServiceWeaver/weaver-kube/releases/tag/v0.17.0
WEAVER_KUBE_BIN_NAME=weaver-kube
WEAVER_KUBE_BIN_VER=v0.17.0
WEAVER_KUBE_BIN_WHICH=$(shell which $(WEAVER_KUBE_BIN_NAME))
WEAVER_KUBE_BIN_WHICH_VERSION=$(shell $(WEAVER_KUBE_BIN_NAME) version)
WEAVER_KUBE_BIN_WHICH_GO_VERSION=$(shell go version $(WEAVER_KUBE_BIN_WHICH))

weaver-print: weaver-dep-print
weaver-dep-print:
	@echo ""
	@echo "-- BIN --"
	@echo "WEAVER_BIN_NAME:                   $(WEAVER_BIN_NAME)"
	@echo "WEAVER_BIN_VER:                    $(WEAVER_BIN_VER)"
	@echo "WEAVER_BIN_WHICH:                  $(WEAVER_BIN_WHICH)"
	@echo "WEAVER_BIN_WHICH_VERSION:          $(WEAVER_BIN_WHICH_VERSION)"
	@echo "WEAVER_BIN_WHICH_GO_VERSION:       $(WEAVER_BIN_WHICH_GO_VERSION)"
	
	@echo ""
	@echo "WEAVER_GKE_BIN_NAME:                $(WEAVER_GKE_BIN_NAME)"
	@echo "WEAVER_GKE_BIN_VER:                 $(WEAVER_GKE_BIN_VER)"
	@echo "WEAVER_GKE_BIN_WHICH:               $(WEAVER_GKE_BIN_WHICH)"
	@echo "WEAVER_GKE_BIN_WHICH_VERSION:       $(WEAVER_GKE_BIN_WHICH_VERSION)"
	@echo "WEAVER_GKE_BIN_WHICH_GO_VERSION:    $(WEAVER_GKE_BIN_WHICH_GO_VERSION)"

	@echo ""
	@echo "WEAVER_KUBE_BIN_NAME:               $(WEAVER_KUBE_BIN_NAME)"
	@echo "WEAVER_KUBE_BIN_VER:                $(WEAVER_KUBE_BIN_VER)"
	@echo "WEAVER_KUBE_BIN_WHICH:              $(WEAVER_KUBE_BIN_WHICH)"
	@echo "WEAVER_KUBE_BIN_WHICH_VERSION:      $(WEAVER_KUBE_BIN_WHICH_VERSION)"
	@echo "WEAVER_KUBE_BIN_WHICH_GO_VERSION:   $(WEAVER_KUBE_BIN_WHICH_GO_VERSION)"

	@echo ""

### DEP 

weaver-dep:
	go install github.com/ServiceWeaver/weaver/cmd/weaver@$(WEAVER_BIN_VER)
	go install github.com/ServiceWeaver/weaver-gke/cmd/weaver-gke@$(WEAVER_GKE_BIN_VER)
	go install github.com/ServiceWeaver/weaver-kube/cmd/weaver-kube@$(WEAVER_KUBE_BIN_VER)


### TEMPLATE

WEAVER_SRC_NEW_TEMPLATE_FSPATH=$(PWD)/template
WEAVER_SRC_NEW_MOD_SOURCE=github.com/ServiceWeaver/template
WEAVER_SRC_NEW_MOD_TARGET=github.com/gedw99/template

weaver-template-print:
	@echo ""

	@echo "WEAVER_SRC_NEW_TEMPLATE_FSPATH:   $(WEAVER_SRC_NEW_TEMPLATE_FSPATH)"
	@echo "WEAVER_SRC_NEW_MOD_SOURCE:        $(WEAVER_SRC_NEW_MOD_SOURCE)"
	@echo "WEAVER_SRC_NEW_MOD_TARGET:        $(WEAVER_SRC_NEW_MOD_TARGET)"


	@echo ""
weaver-template-dep:
	rm -rf $(WEAVER_SRC_NEW_TEMPLATE_FSPATH)
	gonew $(WEAVER_SRC_NEW_MOD_SOURCE) $(WEAVER_SRC_NEW_MOD_TARGET)



### EXAMPLES

weaver-example-dep:
	rm -rf workshops
	git clone git@github.com:ServiceWeaver/workshops.git



### RUN

# !! adjust as needed to point to project !!
WEAVER_SRC_FSPATH=$(WEAVER_SRC_NEW_TEMPLATE_FSPATH)

WEAVER_CMD=cd $(WEAVER_SRC_FSPATH) && $(WEAVER_BIN_NAME)

weaver-help:
	$(WEAVER_CMD) -h
weaver-version:
	$(WEAVER_CMD) version
weaver-generate:
	$(WEAVER_CMD) generate .
weaver-run:
	cd $(WEAVER_SRC_FSPATH) && go run .
weaver-single:
	$(WEAVER_CMD) single .
weaver-deploy-gke:
	$(WEAVER_CMD) gke deploy weaver.toml
weaver-deploy-kube:
	$(WEAVER_CMD) kube deploy weaver.toml
