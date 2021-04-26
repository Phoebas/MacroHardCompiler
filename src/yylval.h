struct lval{
	int integerConstant;
	int boolConstant;
	double doubleConstant;
	char stringConstant[1024];
	char identifier[32];
};

struct lval yylval;
