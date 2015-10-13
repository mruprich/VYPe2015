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
">="			{printf("OPER >= "); return LEX_GTOE;}
"<="			{printf("OPER <= "); return LEX_LSOE;}
">"				{printf("OPER > "); return LEX_GT;}
"<"				{printf("OPER < "); return LEX_LS;}
"!"				{printf("OPER ! "); return LEX_NEG;}
"*"				{printf("MULT "); return LEX_MULT;}
"/"				{printf("DIVISION "); return LEX_DIV;}
"%"				{printf("MOD "); return LEX_MOD;}
"+"				{printf("PLUS "); return LEX_ADD;}
"-"				{printf("MINUS "); return LEX_SUB;}
"("				{printf("LEFT_BRACKET "); return LEX_LBR;}
")"				{printf("RIGHT_BRACKET "); return LEX_RBR;}
"=="			{printf("OPER == "); return LEX_EQ;}
"!="			{printf("OPER != "); return LEX_NEQ;}
"&&"			{printf("AND "); return LEX_AND;}
"||"			{printf("OR "); return LEX_OR;}
"{"				{printf("LEFT_BRACES "); return LEX_LBRACES;}
"}"				{printf("RIGHT_BRACES "); return LEX_LBRACES;}

";"				{printf("SEMICOLON "); return LEX_SEMICOL;}

main			{printf("MAIN "); return LEX_MAIN;}
if				{printf("IF "); return LEX_IF;}
else			{printf("ELSE "); return LEX_ELSE;}
while			{printf("WHILE "); return LEX_WHILE;}
for				{printf("FOR "); return LEX_FOR;}
break			{printf("BREAK "); return LEX_BREAK;}
continue	{printf("CONTINUE "); return LEX_CONT;}
char			{printf("CHAR "); return LEX_DATA_TYPE;}
string		{printf("STRING "); return LEX_DATA_TYPE;}
int				{printf("INT "); return LEX_DATA_TYPE;}
return		{printf("RET "); return LEX_RET;}
void			{printf("VOID "); return LEX_VOID;}
unsigned	{printf("UNSIGNED "); return LEX_UNSIGNED;}
short			{printf("SHORT "); return LEX_SHORT;}
{STR}			{printf("STRING ", yytext); return LEX_STR;}
{NMR}			{printf("NUMBER ", atol(yytext)); return LEX_NMR;}
{CHAR}		{printf("CHAR ", (char)yytext[1]); return LEX_CHAR;}
{EOL_CHAR}	{printf("EOL_CHAR "); return LEX_CHAR;}
{VAR}			{printf("VAR_ID ", yytext); return LEX_VAR;}

\n				{printf("\n"); return LEX_EOL;}

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
