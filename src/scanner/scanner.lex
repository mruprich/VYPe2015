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

#include <stdio.h>
#include <string.h>
#include "common/codes.h"

//extern int yyFlexLexer::yylex();
#define YY_DECL extern int yylex()
#include "parser.tab.h"
//int yyerror(char *s);
%}

%%

">="			{printf(">= "); return GTOE;}
"<="			{printf("<= "); return LSOE;}
">"				{printf("> "); return GT;}
"<"				{printf("< "); return LS;}
"!"				{printf("! "); return NEG;}
"*"				{printf("* "); return MULT;}
"/"				{printf("/ "); return DIV;}
"%"				{printf("% "); return MOD;}
"+"				{printf("+ "); return ADD;}
"-"				{printf("- "); return SUB;}
"("				{printf("( "); return LBR;}
")"				{printf(") "); return RBR;}
"=="			{printf("== "); return EQ;}
"!="			{printf("!= "); return NEQ;}
"&&"			{printf("&& "); return AND;}
"||"			{printf("|| "); return OR;}

"="			{printf("= "); return ASSIGN;}
"{"			{printf("{ "); return BEGIN_TOK;}
"}"			{printf("} "); return END_TOK;}
";"				{printf("; "); return SEMICOL;}

if				{printf("IF "); return IF;}
else			{printf("ELSE "); return ELSE;}
while			{printf("WHILE "); return WHILE;}
for				{printf("FOR "); return FOR;}
break			{printf("BREAK "); return BREAK;}
continue	{printf("CONTINUE "); return CONT;}
char			{printf("CHAR "); CHAR;}
string		{printf("STRING "); return STR;}
int				{printf("INT "); return INT;}
return		{printf("RETURN "); return RET;}
main		{printf("MAIN "); return MAIN;}
void			{printf("VOID "); return VOID;}
unsigned	{printf("UNSIGNED "); return UNSIGNED;}
short			{printf("SHORT "); return SHORT;}
{STR}			{printf("STR "); return STR;}
{NMR}			{printf("NMR:%d ", atol(yytext));  /*yylval.int_val = atol(yytext);*/ return NMR;}
{CHAR}		{printf("CHAR "); return CHAR;}
{EOL_CHAR}	{printf("EOL\n"); return EOL;}
{VAR}			{printf("VAR:%s",yytext); /*yylval.op_val = strdup(yytext);*/ return VAR;}


\n				{printf("\n");}

"/*"			{
						int multiline_comment = 1;
						char c;
						do
						{
							while((c=yyinput()) != '*')
							{
								if(c==EOF) 
								{
								fprintf(stderr, "Source code error: Unterminated comment block\n"); 
								 
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
/*int main(int, char **)
{
	yylex();
	return 100;
}*/
