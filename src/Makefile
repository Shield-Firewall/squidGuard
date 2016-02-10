SHELL=/bin/sh
.SUFFIXES:
.SUFFIXES: .c .o .pl .pm .pod .html .man


CC	= gcc
CPP	= gcc -E
LEX	= flex
PERL	= /usr/bin/perl
YACC	= bison -y
PERL	= /usr/bin/perl
INSTALL	= /usr/bin/install -c
INSTALL_DATA = ${INSTALL} -m 644
INSTALL_PROGRAM = ${INSTALL}
MKDIR = ../mkinstalldirs

RM = rm -f

CFLAGS	= -I/home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/include -I/usr/local/BerkeleyDB/include
CPPFLAGS= -I/home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/include -I/usr/local/BerkeleyDB/include
LDFLAGS	= -L/home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/lib -L/usr/local/BerkeleyDB/lib
LIBS	= -lpthread  -ldb
DEFS	= -DHAVE_CONFIG_H

INCLUDES= -I.. -I. -I$(srcdir)

COMPILE = $(CC) $(INCLUDES) $(CPPFLAGS) $(DEFS) $(CFLAGS)
LINK    = $(CC) $(LDFLAGS) -o $@

top_srcdir = ..
srcdir     = .


prefix	= /home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/squidGuard/
exec_prefix = ${prefix}
bindir	= $(exec_prefix)/bin
logdir	= /usr/local/squidGuard/log
cfgdir	= /usr/local/squidGuard
infodir	= $(prefix)/info

OBJS	= main.o sgLog.o sgDb.o HTParse.o sgDiv.o sgFree.o y.tab.o lex.yy.o

all::
	@echo making $@ in `basename \`pwd\``

all::	squidGuard
	@echo making $? in `basename \`pwd\``

squidGuard:	$(OBJS)
	$(LINK) $(OBJS) $(LIBS)

conf: y.tab.o lex.yy.o
	$(COMPILE) -o conf y.tab.o lex.yy.o

main.o:	main.c sg.h
	$(COMPILE) -c main.c

sgLog.o:	sgLog.c sg.h
	$(COMPILE) -c sgLog.c

HTParse.o:	HTParse.c wwwsys.h HTEscape.h
	$(COMPILE) -c HTParse.c

sgDiv.o: sgDiv.c sg.h sgEx.h
	$(COMPILE) -c sgDiv.c

sgFree.o: sgFree.c sg.h sgEx.h
	$(COMPILE) -c sgFree.c

sgDb.o:	sgDb.c sg.h
	$(COMPILE) -c sgDb.c

lex.yy.o: lex.yy.c y.tab.h sg.h
	$(COMPILE) -c lex.yy.c

y.tab.o: y.tab.c y.tab.h sg.h sgEx.h
	$(COMPILE) -c y.tab.c

lex.yy.c: sg.l sg.h
	@if [ $(LEX) != ":" ]; then \
	$(LEX) sg.l  ; \
	else \
	echo " " ; \
	echo "No flex/lex found. Copy lex.yy.c.flex to lex.yy.c. " ; \
	echo " " ; \
	cp lex.yy.c.flex lex.yy.c ; \
	fi ;

lex.yy.c.flex: sg.l sg.h
	$(LEX) sg.l
	mv -f lex.yy.c lex.yy.c.flex

y.tab.c y.tab.h: sg.y sg.h
	@if [ "$(YACC)" = "yacc" ]; then \
	   if [ ! -x $(YACC) ]; then \
	      echo " " ; \
	      echo "No yacc/bison found. Copy prepared files for y.tab.h and y.tab.c over. " ; \
	      echo " " ; \
	      cp y.tab.h.bison y.tab.h ; \
	      cp y.tab.c.bison y.tab.c ; \
	   else \
	      $(YACC) -d sg.y  ; \
	   fi ; \
	else \
	   $(YACC) -d sg.y  ; \
	fi ;

y.tab.c.bison y.tab.h.bison: sg.y sg.h
	$(YACC) -d sg.y
	mv -f y.tab.c y.tab.c.bison
	mv -f y.tab.h y.tab.h.bison

#
# Dependencies for installing
#

install::	 install.bin
	@echo making $@ in `basename \`pwd\``

uninstall::	 uninstall.bin
	@echo making $@ in `basename \`pwd\``

install.bin:: squidGuard
	@echo making $@ in `basename \`pwd\``
	@$(MKDIR) $(bindir) $(logdir) $(cfgdir)
	$(INSTALL_PROGRAM) squidGuard $(bindir)/squidGuard

uninstall.bin::
	@echo making $@ in `basename \`pwd\``
	$(RM) $(bindir)/squidGuard

update::
	@echo making $@ in `basename \`pwd\``

update::lex.yy.c.flex y.tab.c.bison y.tab.h.bison

#
# Dependencies for cleanup
#

clean::
	@echo making $@ in `basename \`pwd\``
	$(RM) *~ *.bak core *.log *.error
	$(RM) *.o y.tab.c y.tab.h squidGuard lex.yy.c

realclean:: clean
	@echo making $@ in `basename \`pwd\``
	$(RM) TAGS *.orig

distclean:: realclean
	@echo making $@ in `basename \`pwd\``
	$(RM) Makefile sg.h config.h

#
# Dependencies for maintenance
#


subdir = src

Makefile: Makefile.in ../config.status
	cd .. && CONFIG_FILES=$(subdir)/$@ CONFIG_HEADERS= ./config.status
