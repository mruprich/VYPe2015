/*
 * VYPe 2015
 * Parser
 * xvymla01, xrupri00
 * Martin Vymlatil, Michal Ruprich
 * */

%{
#include <cstdio>
#include <iostream>

using namespace std;

int yyerror(const char *s);
extern "C" int yylex();
int yyparse();
%}

%union{
	int		int_val;
	char*		op_val;
}

%start	program

%token CHAR INT STR VOID SHORT UNSIGNED
%token FOR WHILE
%token IF ELSE
%token RET MAIN BREAK CONT
%token BEGIN_TOK END_TOK ASSIGN SEMICOL EOL
%token	<int_val> 	NMR
%token 	<op_val> 	VAR
%type	<int_val>	exp
%left	OR
%left 	AND
%left	EQ NEQ
%left	LS GT LSOE GTOE	
%left	ADD SUB
%left	MULT DIV MOD
%left 	NEG
%left 	LBR RBR

%%
/*zaciname - zde muze byt deklarace nasledovana definici nebo main*/
program: 	declarations
		| main
;

types:		CHAR | INT | STR | VOID
;

pars_dec:	types | types ',' |
;

declarations:	declarations declaration | declaration
;

declaration:	/* typ ID (seznam_typu_par) */ 
		types VAR LBR pars_dec RBR SEMICOL |
		types VAR LBR pars_dec RBR SEMICOL  definitions
;

block:		BEGIN_TOK statements  END_TOK

definitions:	definitions definition | definition

definition:	/* typ ID (seznam_par) {statement} */
		types VAR LBR types VAR RBR block |
		types VAR LBR types VAR RBR block main
;

main: 		INT MAIN LBR VOID RBR block 
;

statements:	statements statement | statement	
;

statement:	assigment |
		while |
		ifelse |
		call	
;

assigment:	VAR ASSIGN exp
;

while:		WHILE
;

ifelse:		IF
;

call:		RET
;

exp:		NMR	{cout << "bison found an int: " << $1 << endl; }
		| VAR  {cout << "bison found a varialbe: " << $1 << endl; }
;
%%

int yyerror(string s) 
{
	extern int yylineno;
	extern char *yytext;

//	cerr << "ERROR: " << s << at symbol \"" << yytext;
//	cerr << "\" on line " << yylineno << endl;
	cerr << "ERROR ... " << endl;
	return 1;
}

int yyerror(const char *s)
{
	return yyerror(string(s));
}
