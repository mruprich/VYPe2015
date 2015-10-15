# Makefile, VYPe 2015
# Martin Vymlatil, Michal Ruprich
# xvymla01, xrupri00

PROJ 	= compiler
OBJS 	= parser.o scanner.o main.o

CC	= g++
CFLAGS	= -g -Wall -pedantic					

#all:
#		$(MAKE) -C ../build

$(PROJ):	$(OBJS)		
		$(CC) $(CFLAGS) $(OBJS) -o $(PROJ) -lfl	

parser.o:	parser.tab.cc
		$(CC) $(CFLAGS) -c parser.tab.cc -o parser.o	

parser.tab.cc:	parser/parser.y
		bison -d -v parser/parser.y -o parser.tab.cc
		
scanner.o:	lex.yy.c
		$(CC) $(CLFAGS) -c lex.yy.cc -o scanner.o

lex.yy.c:	scanner/scanner.lex
		flex --noyywrap scanner/scanner.lex	

main.o:		main.cpp
		$(CC) $(CFLAGS) -c main.cpp -o main.o

clean:
	rm -f *.o lex.yy.cc *.tab.* *.output $(PROJ)

