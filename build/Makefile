SDIR = ../src
IDIR = ../include
TDIR = ../benchmark

CC = gcc
CFLAGS = -I$(IDIR) -lfl

test: lex
	@for file in ../benchmark/*.mh; do \
		./scan $$file > ../benchmark/"$${file%.*}_scanned"; done

lex:
	@flex $(SDIR)/scan.l
	@$(CC) lex.yy.c $(CFLAGS) -o scan

clean:
	@find . ! -name 'Makefile' -type f -exec rm -f {} +
	@find ../benchmark ! -name *.mh -type f -exec rm -f {} +
