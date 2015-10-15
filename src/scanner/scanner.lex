VAR	[_a-zA-Z]([_a-zA-Z0-9])*
NMR [0-9]+
STR \"(\\\"|[^\"])*\"
CHAR \'.\'
EOL_CHAR \'\\n\'

%{
/*
 * VYPe 2015
 * xvymla00, xrupri00
 * Martin Vymlatil, Michal Ruprich
 * */

#include <cstdio>
#include <string.h>
#include "../src/common/codes.h"

using namespace std;

#include "parser.tab.hh"
extern int yylex();
int yyerror(char *s);
%}

%option c++

%%
">="			{return GTOE;}
"<="			{return LSOE;}
">"				{return GT;}
"<"				{return LS;}
"!"				{return NEG;}
"*"				{return MULT;}
"/"				{return DIV;}
"%"				{return MOD;}
"+"				{return ADD;}
"-"				{return SUB;}
"("				{return LBR;}
")"				{return RBR;}
"=="			{return EQ;}
"!="			{return NEQ;}
"&&"			{return AND;}
"||"			{return OR;}

"="			{return ASSIGN;}
"{"			{return BEGIN_TOK;}
"}"			{return END_TOK;}
";"				{return SEMICOL;}

if				{return IF;}
else			{return ELSE;}
while			{return WHILE;}
for				{return FOR;}
break			{return BREAK;}
continue	{return CONT;}
char			{return CHAR;}
string		{return STR;}
int				{return INT;}
return		{return RET;}
main		{return MAIN;}
void			{return VOID;}
unsigned	{return UNSIGNED;}
short			{return SHORT;}
{STR}			{return STR;}
{NMR}			{yylval.int_val = atol(yytext); return NMR;}
{CHAR}		{return CHAR;}
{EOL_CHAR}	{return CHAR;}
{VAR}			{yylval.op_val = strdup(yytext); return VAR;}


\n				{return EOL;}

"/*"			{
						int multiline_comment = 1;
						char c;
						do
						{
							while((c=yyinput()) != '*')
							{
								if(c==EOF) 
								{
								printf("Source code error: Unterminated comment block\n"); 
								 
									return LEXICAL_ERR;
								}
							}
							
							while((c=yyinput()) == '*');
							if(c=='/')
								multiline_comment=0;
						}while(multiline_comment);
					}

"//"			{
						char c;
						while((c=yyinput()) != '\n');
					}
%%
/*int main()
{
	FlexLexer* lexer = new yyFlexLexer();
	while(lexer->yylex() != 0)
		;

	return CAJK;
}*/
