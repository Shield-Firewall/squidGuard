SHELL=/bin/sh
.SUFFIXES:
.SUFFIXES: .c .o .pl .pm .pod .html .man

PERL = /usr/bin/perl

CC = gcc
CFLAGS = -I/home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/include -I/usr/local/BerkeleyDB/include
INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_PROGRAM = ${INSTALL}
LDFLAGS = -L/home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/lib -L/usr/local/BerkeleyDB/lib
LIBS = -lpthread  -ldb

RM = rm -f
MKINSTALLDIRS = mkdir -p

prefix = /home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/squidGuard/
exec_prefix = ${prefix}
bindir = $(exec_prefix)/bin
infodir = $(prefix)/info
logdir = /usr/local/squidGuard/log
configfile = /usr/local/squidGuard/squidGuard.conf
dbhomedir = /usr/local/squidGuard/db
SQUIDUSER = squid

SUBDIRS = src test samples contrib
INSTALL_TARGETS = install-conf install-build

all::
	@echo making $@ in `basename \`pwd\``

all update clean distclean realclean::
	@for subdir in $(SUBDIRS); do \
		(cd $$subdir && $(MAKE) $(MAKEDEFS) $@) || exit 1; \
	done

test::
	@echo making $@ in `basename \`pwd\``
	(cd $@ && $(MAKE) $(MAKEDEFS) $@)

#
# Dependencies for installing
#	

install:	install-build install-conf

install-conf:
	@echo Installing configuration file  ;
	@if [ ! -d $(prefix)/squidGuard ]; then \
		$(MKINSTALLDIRS) $(prefix)/squidGuard ; \
		echo Created directory $(prefix)/squidGuard ; \
		chown -R $(SQUIDUSER) $(prefix)/squidGuard || exit 1  ; \
		echo Assigned $(prefix)/squidGuard to user $(SQUIDUSER) ; \
	fi ; 
	@if [ ! -d $(dbhomedir) ]; then \
		$(MKINSTALLDIRS) $(dbhomedir) ; \
		echo Created directory $(dbhomedir) ; \
		chown -R $(SQUIDUSER) $(dbhomedir) || exit 1 ; \
		echo Assigned $(dbhomedir) to user $(SQUIDUSER) ; \
	fi ; 
	@if [ ! -d $(logdir) ]; then \
		$(MKINSTALLDIRS) $(logdir) ; \
		echo Created directory $(logdir) ; \
		chown -R $(SQUIDUSER) $(logdir) || exit 1 ; \
		echo Assigned $(logdir) to user $(SQUIDUSER) ; \
	fi ; 
	@if [ ! -d `dirname $(configfile)` ]; then \
		umask 022 ; \
		mkdir -p `dirname $(configfile)` ; \
		echo No configuration directory found. Created `dirname $(configfile)`. ; \
	fi;
	@if test ! -f $(configfile); then \
		cp samples/sample.conf $(configfile) || exit 1  ; \
		echo Copied sample squidGuard.conf ; \
		chmod 644 $(configfile) || exit 1 ; \
		echo $(configfile) is now readable ; \
		echo The initial configuration is complete. ; \
	else \
		echo Configuration file found. Not changing anything ; \
	fi; 
	@echo ;
	@echo Congratulation. SquidGuard is sucessfully installed. ;
	@echo ;

install-build:
	@echo Installing squidGuard 
	@if [ ! -d $(bindir) ]; then \
		$(MKINSTALLDIRS) $(bindir) ; \
	fi ; \
	cp src/squidGuard $(bindir) || exit 1 ;  \
	echo Done. ;

clean::
	@echo making $@ in `basename \`pwd\``
	$(RM) *~ *.bak core *.log *.error

realclean::
	@echo making $@ in `basename \`pwd\``
	$(RM) *~ *.bak core
	$(RM) TAGS *.orig

distclean::
	@echo making $@ in `basename \`pwd\``
	$(RM) *~ *.bak core
	$(RM) TAGS *.orig
	$(RM) Makefile config.h config.status config.log config.cache

version::	src/version.h
	@echo making $@ in `basename \`pwd\``
	cp -p src/version.h src/version.h~
	sed 's/^#define VERSION .*/#define VERSION "1.4"/' <src/version.h~ >src/version.h \
	|| mv -f src/version.h~ src/version.h
	-cmp -s src/version.h~ src/version.h && mv -f src/version.h~ src/version.h || :
	$(RM) src/version.h~

update::	announce readme changelog
	@echo making $@ in `basename \`pwd\``

announce::	ANNOUNCE
	@echo making $@ in `basename \`pwd\``
	test -d  && ( cmp -s ANNOUNCE /ANNOUNCE || \
	$(INSTALL_DATA) ANNOUNCE /ANNOUNCE )

readme:: 	README
	@echo making $@ in `basename \`pwd\``
	test -d  && ( cmp -s README /README || \
	$(INSTALL_DATA) README /README )

changelog::	CHANGELOG
	@echo making $@ in `basename \`pwd\``
	test -d  && ( cmp -s CHANGELOG /CHANGELOG || \
	$(INSTALL_DATA) CHANGELOG /CHANGELOG )
