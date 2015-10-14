#include <cstdio>

using namespace std;

extern "C" int yyparse();

int main (int argc, char **argv) 
{
	printf("AHOJ... zaciname!\n");
	
	if ((argc > 1) && (freopen(argv[1], "r", stdin)))
        {		
		printf("neotevren....\n");
		return 1;	
	}
	yyparse();

	return 0;
}


