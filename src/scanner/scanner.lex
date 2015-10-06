VAR	[_a-zA-Z]([_a-zA-Z0-9])*
NMR [0-9]+

%{
/*
 * VYPe 2015
 * xvymla00, xrupri00
 * Martin Vymlatil, Michal Ruprich
 * */

#include <stdio.h>
#include "../src/common/codes.h"

%}

%%
">="			{return LEX_GTOE;}
"<="			{return LEX_LSOE;}
">"				{return LEX_GT;}
"<"				{return LEX_LS;}
"!"				{return LEX_NEG;}
"*"				{return LEX_MULT;}
"/"				{return LEX_DIV;}
"%"				{return LEX_MOD;}
"+"				{return LEX_ADD;}
"-"				{return LEX_SUB;}
"("				{return LEX_LBR;}
")"				{return LEX_RBR;}
"=="			{return LEX_EQ;}
"!="			{return LEX_NEQ;}
"&&"			{return LEX_AND;}
"||"			{return LEX_OR;}

";"				{return LEX_SEMICOL;}

if				{return LEX_IF;}
else			{return LEX_ELSE;}
while			{return LEX_WHILE;}
for				{return LEX_FOR;}
break			{return LEX_BREAK;}
continue	{return LEX_CONT;}
char			{return LEX_CHAR;}
string		{return LEX_STR;}
int				{return LEX_INT;}
return		{return LEX_RET;}
void			{return LEX_VOID;}
unsigned	{return LEX_UNSIGNED;}
short			{return LEX_SHORT;}
{VAR}			{return LEX_VAR;}
{NMR}			{return LEX_NMR;}

\n				{return LEX_EOL;}

"/*"			{
						int multiline_comment = 1;
						char c;
						do
						{
							while((c=input()) != '*')
							{
								if(c==EOF) 
								{
									printf("Source code error: Unterminated comment block\n"); 
									return LEXICAL_ERR;
								}
							}
							
							while((c=input()) == '*');
							if(c=='/')
								multiline_comment=0;
						}while(multiline_comment);
					}

"//"			{
						char c;
						while((c=input()) != '\n');
					}
%%
int main()
{
	yylex();


	return CAJK;
}
