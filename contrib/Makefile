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

update:: squidGuardRobot

squidGuardRobot:: squidGuardRobot/squidGuardRobot.in squidGuardRobot/RobotUserAgent.pm

squidGuardRobot/squidGuardRobot.in: 
	@echo making $@ in `basename \`pwd\``
	@$(MKDIR) squidGuardRobot
	cp -p $? $@
	chmod 660 $@
	$(PERL) -0777 -pi -e 's;^#!\s?/\S*perl;#! \100PERL\100;' $@

squidGuardRobot/RobotUserAgent.pm: 
	@echo making $@ in `basename \`pwd\``
	@$(MKDIR) squidGuardRobot
	cp -p $? $@
	chmod 660 $@

clean::
	@echo making $@ in `basename \`pwd\``
	$(RM) *~ *.bak core *.log *.error

realclean:: clean
	@echo making $@ in `basename \`pwd\``
	$(RM) TAGS *.orig

distclean:: realclean
	@echo making $@ in `basename \`pwd\``
	$(RM) Makefile
	$(RM) squidGuardRobot/squidGuardRobot
	$(RM) sgclean/sgclean
	$(RM) hostbyname/hostbyname
