# Makefile, VYPe 2015
# Martin Vymlatil, Michal Ruprich
# xvymla01, xrupri00

PROJ 	= compiler
OBJS 	= parser.o scanner.o main.o

CC	= g++
CFLAGS	= -std=c++11 -g -pedantic

#all:
#		$(MAKE) -C ../build

#all: lex.yy.c cpp_all
all: parser.tab.c lex.yy.c cpp_all

parser.tab.c:	parser/parser.y
		bison -d -v parser/parser.y -o parser.tab.c

lex.yy.c:	scanner/scanner.lex
		flex  --noyywrap scanner/scanner.lex	

cpp_all:
#		$(CC) $(CFLAGS) lex.yy.c -o scan
		$(CC) $(CFLAGS) parser.tab.c lex.yy.c -o $(PROJ) 
		

clean:
	rm -f *.o lex.yy.c *.tab.* *.output $(PROJ)

