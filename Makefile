BIN = $(DESTDIR)/usr/bin
DEFAULT = $(DESTDIR)/etc/default
PROFILED = $(DESTDIR)/etc/profile.d
LIB = $(DESTDIR)/usr/lib
SHARE = $(DESTDIR)/usr/share
MAN = $(SHARE)/man

MANPAGES = man/chkboot.8 \
	   man/chkboot-check.8 \
	   man/chkboot-desktopalert.8

all: man

man: $(MANPAGES)

$(MANPAGES): %.8: %.8.rst
	rst2man $< > $@

clean:
	rm -vf man/*.8

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

install-systemd: install
	install -D -m644 chkboot.service $(LIB)/systemd/system/chkboot.service
	install -D -m755 chkboot-bootcheck $(LIB)/systemd/scripts/chkboot-bootcheck

install-man: man
	$(foreach manpage,$(MANPAGES),install -D -m644 $(manpage) $(MAN)/man8/$(notdir $(manpage));)

.PHONY: all install install-initcpio install-pacman install-systemd man install-man clean
