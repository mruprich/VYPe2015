# VYPe2015
University project - compiler creation

Compiling and running the scanner:
	$cd build
	$flex++ --noyywrap ../src/scanner/scanner.lex 
	(-this will generate lex.yy.c in build directory)
	$g++ lex.yy.cc -o scanner -lfl
	(-I think you need to install flex-devel to use the -lfl it so in case it doesn't work - try that)
	
Now you can use the scanner like this:
	$./scanner < input
		OR
	$./scanner
	-and than use the stdin
