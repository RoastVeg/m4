#	$NetBSD: Makefile,v 1.19 2015/01/29 19:26:20 christos Exp $
#
#	@(#)Makefile	8.1 (Berkeley) 6/6/93

# -DEXTENDED 
# 	if you want the paste & spaste macros.

PROG=		m4
CPPFLAGS=	-DEXTENDED -I$(CURDIR)/lib -lfl -lbsd -isystem /usr/include/bsd -DLIBBSD_OVERLAY -D'__dead=__attribute__((__noreturn__))' -D'__UNCONST(a)=(void*)(intptr_t)(a)'
SRCS=	parser.c tokenizer.c eval.c expr.c look.c main.c misc.c gnum4.c trace.c \
	lib/ohash_create_entry.c lib/ohash_delete.c lib/ohash_do.c lib/ohash_entries.c \
	lib/ohash_enum.c lib/ohash_init.c lib/ohash_interval.c lib/ohash_lookup_interval.c \
	lib/ohash_lookup_memory.c lib/ohash_qlookup.c lib/ohash_qlookupi.c

INSTALL=	install -c
PREFIX=		/usr/local
MANDIR=		$(PREFIX)/share/man
YACC?=		yacc
YFLAGS?=	-y --defines=parser.h #-H parser.h

all: tokenizer.c
	$(CC) $(CPPFLAGS) $(SRCS) -o $(PROG)

tokenizer.c:
	$(YACC) $(YFLAGS) -o parser.c parser.y
	lex -o tokenizer.c tokenizer.l

clean:
	rm -f *.o $(PROG) parser.c parser.h tokenizer.c

install:
	$(INSTALL) $(PROG) $(PREFIX)/bin
	$(INSTALL) -m 0644 $(PROG).1 

