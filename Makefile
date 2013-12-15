.POSIX:

PREFIX?=/usr/local
BINPREFIX?=${PREFIX}/bin
SHAREPREFIX=${BINPREFIX}/../share

SRCFILES=src/header.sh \
 src/color.sh \
 src/variables.sh \
 src/text.sh \
 src/blocks.sh \
 src/language.sh

test: share/shpec/shpec.sh
	@bin/shpec

share/shpec/shpec.sh: ${SRCFILES}
	cat ${SRCFILES} > $@

install: install-bin install-share

install-bin:
	chmod -R +x bin
	mkdir -p ${BINPREFIX}
	cp -r -v bin/* ${BINPREFIX}/

install-share:
	mkdir -p ${SHAREPREFIX}
	cp -r -v share/* ${SHAREPREFIX}/
