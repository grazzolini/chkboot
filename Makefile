BIN = $(DESTDIR)/usr/bin
ETC = $(DESTDIR)/etc
DEFAULT = $(DESTDIR)/etc/default
PROFILED = $(DESTDIR)/etc/profile.d
LIB = $(DESTDIR)/usr/lib
SHARE = $(DESTDIR)/usr/share

all:

install:
	install -D -m644 chkboot.conf $(DEFAULT)/chkboot.conf
	install -D -m755 chkboot $(BIN)/chkboot
	install -D -m755 chkboot-check $(BIN)/chkboot-check
	install -D -m755 notification/chkboot-profilealert.sh $(PROFILED)/chkboot-profilealert.sh
	install -D -m755 notification/chkboot-desktopalert $(BIN)/chkboot-desktopalert

install-initcpio: install
	install -D -m644 mkinitcpio-hooks/chkboot-initcpio $(LIB)/initcpio/install/chkboot

install-pacman: install
	install -D -m644 pacman-hooks/80-chkboot-check.hook $(SHARE)/libalpm/hooks/80-chkboot-check.hook
	install -D -m644 pacman-hooks/99-chkboot-update.hook $(SHARE)/libalpm/hooks/99-chkboot-update.hook

install-apt: install
	install -D -m644 apt-hooks/05chkboot $(ETC)/apt/apt.conf.d/05chkboot
	install -D -m755 apt-hooks/chkboot-update $(LIB)/chkboot/chkboot-update

install-systemd: install
	install -D -m644 chkboot.service $(LIB)/systemd/system/chkboot.service
	install -D -m755 chkboot-bootcheck $(LIB)/systemd/scripts/chkboot-bootcheck

.PHONY: all install install-initcpio install-pacman install-systemd install-apt
