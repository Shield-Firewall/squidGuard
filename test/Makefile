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

prefix = /home/vinoth/centos7dev/utm/utmbuild/bldrpm/BUILDROOT/srootfs/usr/local/squidGuard/
exec_prefix = ${prefix}
bindir = $(exec_prefix)/bin
infodir = $(prefix)/info

all::
	@echo making $@ in `basename \`pwd\``

all::	test1.conf test2.conf
	@echo making $@ in `basename \`pwd\``

test::	test1 test2 benchmark

test1 test2::	test1.conf test2.conf ../src/squidGuard requests
	@echo $@..
	@$(RM) squidGuard.log
	@echo Database size:
	@if [ $@ = test1 ];\
	then\
	    wc -l blacklist/domains blacklist/urls;\
	else\
	    wc -l blacklist/domains blacklist/urls blacklist/expressions;\
	fi
	@wc -l<requests | awk '{printf "Running $@ with %d requests..",$$1}'
	@-cat requests | ../src/squidGuard -c $@.conf | grep -v Processing |grep -v done >$@.output; exit 0
	@echo .Done
	@echo  "Checking number of output lines.."
	@test `wc -l<requests` -eq `wc -l<$@.output`
	@echo .OK
	@echo  "Checking the output against the expected.."
	@cmp -s $@.output $@.expected
	@echo .OK
	@lines=`wc -l<requests`;\
	awk -F'[()]' '/ squidGuard.+started \([0-9]+\.[0-9]+\)$$/ {start=$$(NF-1)};\
		       / squidGuard ready for requests \([0-9]+\.[0-9]+\)$$/ {ready=$$(NF-1)};\
		       / squidGuard stopped \([0-9]+\.[0-9]+\)$$/ {stop=$$(NF-1)};\
		       END {printf "squidGuard initialization took %.3f seconds\n",ready-start;\
			    printf "squidGuard handled %d requests in %.3f seconds\n",\
			    '"$$lines"',stop-ready}' \
		squidGuard.log
	@echo ""

benchmark::	test1.conf ../src/squidGuard requests
	@echo $@..
	@$(RM) squidGuard.log
	@echo Database size:
	@wc -l blacklist/domains blacklist/urls
	@wc -l<requests | awk '{printf "Running $@ test with %d requests..",$$1*100}'
	@-i=100; while [ $$i -gt 0 ]; do cat requests; i=`expr $$i - 1`;done \
	| ../src/squidGuard -c test1.conf>/dev/null; exit 0
	@echo .Done
	@lines=`wc -l<requests`;\
	awk -F'[()]' '/ squidGuard.+started \([0-9]+\.[0-9]+\)$$/ {start=$$(NF-1)};\
		       / squidGuard ready for requests \([0-9]+\.[0-9]+\)$$/ {ready=$$(NF-1)};\
		       / squidGuard stopped \([0-9]+\.[0-9]+\)$$/ {stop=$$(NF-1)};\
		       END {printf "squidGuard initialization took %.3f seconds\n",ready-start;\
			    printf "squidGuard handled %d requests in %.3f seconds\n",\
			    '"$$lines"'*100,stop-ready}' \
		squidGuard.log

../src/squidGuard:
	@echo making $@ in `basename \`pwd\``
	(cd ../src; make squidGuard)

update::
	@echo making $@ in `basename \`pwd\``

clean::
	@echo making $@ in `basename \`pwd\``
	$(RM) *~ *.bak core *.log *.error
	$(RM) blacklist/*~ blacklist/*.bak blacklist/core
	$(RM) squidGuard.log squidGuard.log test1.output test2.output

realclean:: clean
	@echo making $@ in `basename \`pwd\``
	$(RM) TAGS *.orig

distclean:: realclean
	@echo making $@ in `basename \`pwd\``
	$(RM) Makefile test1.conf test2.conf
