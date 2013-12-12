.POSIX:

PREFIX?=/usr/local
BINPREFIX?=${PREFIX}/bin

install: install-bin

install-bin:
	chmod -R +x bin
	mkdir -p ${BINPREFIX}
	cp -r -v bin/* ${BINPREFIX}/
