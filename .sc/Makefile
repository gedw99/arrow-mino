# injector. copy all includes into project
# relies on ENV and sc-make git repo.

SOURCE=$(SC_MAKE_FSPATH)
TARGET=$(PWD)/..

sc-print:
	@echo ""

	@echo "SOURCE:   $(SOURCE)"
	@echo "TARGET:   $(TARGET)"

sc-list:
	@echo ""
	@echo "-- SOURCE --"
	ls -al $(SOURCE)/*.mk

	@echo ""
	@echo "-- SOURCE --"
	ls -al $(TARGET)/*.mk


sc-dep-del:
	# del all present
	rm -f $(TARGET)/*.mk

sc-dep: sc-dep-del
	# copy in
	# list has to be an exactly what Makefile includes

	cp $(SOURCE)/help.mk $(TARGET)

	cp $(SOURCE)/caddy.mk $(TARGET)
	cp $(SOURCE)/fly.mk $(TARGET)
	cp $(SOURCE)/go.mk $(TARGET)
	cp $(SOURCE)/hcloud.mk $(TARGET)
	cp $(SOURCE)/minio.mk $(TARGET)
	cp $(SOURCE)/nats.mk $(TARGET)
	cp $(SOURCE)/overmind.mk $(TARGET)
