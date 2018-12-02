PROGNM ?= efi-roller
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
SHRDIR ?= $(PREFIX)/share
DOCDIR ?= $(PREFIX)/share/doc
MANDIR ?= $(PREFIX)/share/man
CONFDIR ?= /etc
MANS = $(basename $(wildcard docs/*.txt))

all: man efi-roller
man: $(MANS)
$(MANS):

docs/efi-roller.%: docs/efi-roller.%.txt docs/asciidoc.conf
	a2x --no-xmllint --asciidoc-opts="-f docs/asciidoc.conf" -d manpage -f manpage -D docs $<

install: man
	install -Dm755 efi-roller -t $(DESTDIR)$(BINDIR)
	for manfile in $(MANS); do \
		install -Dm644 $$manfile -t $(DESTDIR)$(MANDIR)/man$${manfile##*.}; \
	done;
	install -Dm644 LICENSE -t $(DESTDIR)$(SHRDIR)/licenses/$(PROGNM)

clean:
	rm -f $(MANS)
