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
#include "../src/common/codes.h"
#include "../src/common/tokens.h"

//extern int yylex(void);
%}

%option c++

%%
">="			{printf("OPER >=\n"); return LEX_GTOE;}
"<="			{printf("OPER <=\n"); return LEX_LSOE;}
">"				{printf("OPER >\n"); return LEX_GT;}
"<"				{printf("OPER <\n"); return LEX_LS;}
"!"				{printf("OPER !\n"); return LEX_NEG;}
"*"				{printf("MULT\n"); return LEX_MULT;}
"/"				{printf("DIVISION\n"); return LEX_DIV;}
"%"				{printf("MOD\n"); return LEX_MOD;}
"+"				{printf("PLUS\n"); return LEX_ADD;}
"-"				{printf("MINUS\n"); return LEX_SUB;}
"("				{printf("LEFT BRACKET\n"); return LEX_LBR;}
")"				{printf("RIGHT BRACKET\n"); return LEX_RBR;}
"=="			{printf("OPER ==\n"); return LEX_EQ;}
"!="			{printf("OPER !=\n"); return LEX_NEQ;}
"&&"			{printf("AND\n"); return LEX_AND;}
"||"			{printf("OR\n"); return LEX_OR;}

";"				{printf("SEMICOLON\n"); return LEX_SEMICOL;}

if				{printf("IF\n"); return LEX_IF;}
else			{printf("ELSE\n"); return LEX_ELSE;}
while			{printf("WHILE\n"); return LEX_WHILE;}
for				{printf("FOR\n"); return LEX_FOR;}
break			{printf("BREAK\n"); return LEX_BREAK;}
continue	{printf("CONTINUE\n"); return LEX_CONT;}
char			{printf("CHAR\n"); return LEX_DATA_TYPE;}
string		{printf("STRING\n"); return LEX_DATA_TYPE;}
int				{printf("INT\n"); return LEX_DATA_TYPE;}
return		{printf("RET\n"); return LEX_RET;}
void			{printf("VOID\n"); return LEX_VOID;}
unsigned	{printf("UNSIGNED\n"); return LEX_UNSIGNED;}
short			{printf("SHORT\n"); return LEX_SHORT;}
{STR}			{printf("STRING: %s\n", yytext); return LEX_STR;}
{NMR}			{printf("NUMBER: %d\n", atol(yytext)); return LEX_NMR;}
{CHAR}		{printf("CHAR: %c\n", (char)yytext[1]); return LEX_CHAR;}
{EOL_CHAR}	{printf("EOL_CHAR: \\n\n"); return LEX_CHAR;}
{VAR}			{printf("VAR ID: %s\n", yytext); return LEX_VAR;}

\n				{return LEX_EOL;}

"/*"			{
						register int multiline_comment = 1;
						register char c;
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
int main()
{
	FlexLexer* lexer = new yyFlexLexer();
	while(lexer->yylex() != 0)
		;

	return CAJK;
}
