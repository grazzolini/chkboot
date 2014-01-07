BIN = $(DESTDIR)/usr/bin
DEFAULT = $(DESTDIR)/etc/default
PROFILED = $(DESTDIR)/etc/profile.d
LIB = $(DESTDIR)/usr/lib

install:
	install -D -m644 chkboot.conf $(DEFAULT)/chkboot.conf
	install -D -m755 chkboot $(BIN)/chkboot
	install -D -m755 chkboot-check $(BIN)/chkboot-check
	install -D -m755 chkboot-profilealert.sh $(PROFILED)/chkboot-profilealert.sh

install-initcpio: install
	install -D -m644 chkboot-initcpio $(LIB)/initcpio/install/chkboot

install-systemd: install
	install -D -m644 chkboot.service $(LIB)/systemd/system/chkboot.service
	install -D -m755 chkboot-bootcheck $(LIB)/systemd/scripts/chkboot-bootcheck
	systemctl --system daemon-reload
	systemctl enable chkboot

.PHONY: install install-initcpio install-systemd
