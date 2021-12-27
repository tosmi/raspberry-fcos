PREP_DIR := $(HOME)/tmp/RPi4boot
RELEASE  := 35

.PHONY: prep
prep:
	mkdir -p $(PREP_DIR)
	sudo dnf install -y --downloadonly --release=$(RELEASE) --forcearch=aarch64 --destdir=$(PREP_DIR)  uboot-images-armv8 bcm283x-firmware bcm283x-overlays

.PHONY: extract
extract:
	for rpm in $(PREP_DIR)/*rpm; do rpm2cpio $$rpm | sudo cpio -idv -D $(HOME)/tmp/RPi4boot/; done
	sudo mv $(PREP_DIR)/usr/share/uboot/rpi_4/u-boot.bin $(PREP_DIR)/boot/efi/rpi4-u-boot.bin

.PHONY: butane
butane:
