/*
 * VYPe 2015
 * Parser
 * xvymla01, xrupri00
 * Martin Vymlatil, Michal Ruprich
 * */

%{
#include <stdio.h>
extern int yylex();
extern void yyerror(const char* str);
extern FILE *yyin;
%}

%union{
	int		int_val;
	char*		op_val;
}

%start	program

%token EOL 

%token CHAR INT STR VOID SHORT UNSIGNED
%token LBR RBR
%token FOR WHILE
%token IF ELSE
%token RET MAIN BREAK CONT
%token BEGIN_TOK END_TOK ASSIGN SEMICOL
%token	<int_val> 	NMR
%token 	<op_val> 	VAR
%type	<int_val>	exp
%left	OR
%left AND
%left	EQ NEQ
%left	LS GT LSOE GTOE	
%left	ADD SUB
%left	MULT DIV MOD
%left NEG
%left LBR RBR

%%
/*zaciname - zde muze byt deklarace nasledovana definici nebo main*/
program: /*deklarace nebo main*/	
		declarations main | main
;

main: 		
		INT MAIN LBR VOID RBR block
;

declarations:	
	/*eps*/
	| declaration declarations
;

declaration:	/* typ ID (seznam_typu_par) - pak muze nasledovat bud strednik, nebo primo definice*/ 
		types VAR LBR pars_dec RBR SEMICOL decl_cont 
;

decl_cont:
	SEMICOL | block
;

types:		
	CHAR | INT | STR | VOID
;

pars_dec:	
	/*eps*/ |types | types ','
;

block:		
	BEGIN_TOK statements  END_TOK
;


statements:	
		/*eps*/
		| statement statements
;

statement:	
	var_def |
	assigment |
	while |
	ifelse |
	call 
;

var_def:
	types VAR | var_def_cont
;

var_def_cont:
	SEMICOL | VAR var_def_cont
;

assigment:	VAR ASSIGN exp
;

while:		WHILE
;

ifelse:		IF
;

call:		RET
;

exp:		NMR	{printf("bison found an int: %d\n", $1); }
		| VAR  {printf("bison found a variable: %d\n",$1); }
;
%%

//int yyerror(string s) 
//{
//	extern int yylineno;
//	extern char *yytext;

//	cerr << "ERROR: " << s << at symbol \"" << yytext;
//	cerr << "\" on line " << yylineno << endl;
//	cerr << "ERROR ... " << s << endl;
//	return 1;
//}

int main(int argc, char **argv)
{
	printf("main je spusten\n");
	FILE *fp = fopen(argv[1], "r");
	if(fp == NULL)
	{
		printf("Unable to open file %s\n", argv[1]);
		return 0;
	}
	
	yyin = fp;
	int ret = yyparse();
	printf("main konci, ret = %d\n", ret);
}

void yyerror(const char *s)
{
	fprintf(stderr, "error v bisonu: %s\n", s);
}

