VAR	[_a-zA-Z]([_a-zA-Z0-9])*
INT ([0-9])+

%{
/*
 * VYPe 2015
 * xvymla00, xrupri00
 * Martin Vymlatil, Michal Ruprich
 * */

#include <stdio.h>
#include "../src/common/tokens.h"

%}

%%
{VAR}	{printf("VAR ");}
{INT}	{printf("INT");}
'\n'	{printf("EOL\n");}
%%
int main()
{
	yylex();



}
