.PHONY: clean test

SDIR = ../src
IDIR = ../include
TDIR = ../benchmark

CC = gcc
LD = gcc
CFLAGS = -g -I$(IDIR) -Wall -Wno-unused -Wno-sign-compare -Wno-deprecated
LIBS = -lc -lm -lfl

LEX = flex
YACC = bison
LEXFLAGS = -d
YACCFLAGS = -dvty -Wno-other -Wcounterexamples

OBJS = lex.yy.o y.tab.o

test: #link 
	@for file in ../benchmark/*.mh; do \
		./scan $$file > ../benchmark/"$${file%.*}_scanned"; done

.yy.o: $*.yy.c
	$(CC) $(CFLAGS) -c -o $@ $*.c

lex.yy.c: $(SDIR)/scan.l
	$(LEX) $(LEXFLAGS) $(SDIR)/scan.l

y.tab.c: lex.yy.c 
	$(YACC) $(YACCFLAGS) $(SDIR)/parse.y

# y.tab.o : y.tab.c
#	$(CC) $(CFLAGS) -c -o y.tab.o y.tab.c

parse: y.tab.c
	$(CC) $(CFLAGS) $(LIBS) -o parse y.tab.c

# link: $(OBJS)
#	$(LD) -o parse $(OBJS) $(LIBS)
clean:
	@find . ! -name 'Makefile' -type f -exec rm -f {} +
	@find ../benchmark ! -name *.mh -type f -exec rm -f {} +
