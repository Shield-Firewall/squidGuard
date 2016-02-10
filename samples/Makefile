SHELL=/bin/sh
.SUFFIXES:
.SUFFIXES: .c .o .pl .pm .pod .html .man

CC = gcc
CFLAGS = -I/home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/include -I/usr/local/BerkeleyDB/include
INSTALL = /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_PROGRAM = ${INSTALL}
LDFLAGS = -L/home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/lib -L/usr/local/BerkeleyDB/lib
LIBS = -lpthread  -ldb
PERL = /usr/bin/perl
MKDIR = ../mkinstalldirs

RM = rm -f

prefix = /home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/squidGuard/
exec_prefix = ${prefix}
bindir = $(exec_prefix)/bin
infodir = $(prefix)/info

all::
	@echo making $@ in `basename \`pwd\``

update::
	@echo making $@ in `basename \`pwd\``

update:: squidGuard.cgi.in dest/blacklists.tar.gz

squidGuard.cgi.in: 
	@echo making $@ in `basename \`pwd\``
	cp -p $? $@
	$(PERL) -0777 -pi -e 's;^#!\s?/\S*perl;#! \100PERL\100;;s;\.(ost\.eltele|teledanmark)\.no;your-domain;;s;blacklist\\\@squidguard.org;operator\\\@your-domain;;' $@

dest/blacklists.tar.gz:: 
	@echo making $@ in `basename \`pwd\``
	cp -p $? $@
	chmod 660 $@

clean::
	@echo making $@ in `basename \`pwd\``
	$(RM) *~ *.bak core *.log *.error
	$(RM) dest/*~ dest/*.bak dest/core
	$(RM) dest/financial/*~ dest/financial/*.bak dest/financial/core

realclean:: clean
	@echo making $@ in `basename \`pwd\``
	$(RM) TAGS *.orig

distclean:: realclean
	@echo making $@ in `basename \`pwd\``
	$(RM) Makefile sample.conf squidGuard.cgi squidGuard-simple.cgi
