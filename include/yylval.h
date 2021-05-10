#ifndef _YYLVAL_H

#define _YYLVAL_H

#define MAX_IDENTIFIER_LENGTH 32
#define MAX_STRING_LENGTH 1024

#ifndef YYSTYPE

union YYSTYPE{
	int integerConstant;
	int boolConstant;
	double doubleConstant;
	char stringConstant[MAX_STRING_LENGTH];
	char identifier[MAX_IDENTIFIER_LENGTH];
};

#define YYSTYPE union YYSTYPE

#define YYSTYPE_IS_DECLARED 1

#endif

#endif
