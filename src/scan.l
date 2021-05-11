/** 
  * @file MacroHard.l
  * @brief The lex file to generate Lexical Analyzer for MacroHard
  * 
  * @details Scan tokens from stdin
  *
  * @date 2021-04-26
  * @author Yongkang Li
**/

%{

#include "type.h"
#include "yylval.h"

YYSTYPE yylval;

int line = 1;
int err = 0;

%}

%s NORMAL
%x COPY COMMENTS
%option stack

/* Definition */
Identifier 	([A-Za-z_][A-Za-z_0-9]*)
Binary 		([+-]?0[Bb][01]+)
Decimal 	([+-]?[0-9]+)
Hex 		([+-]?0[Xx][0-9A-Fa-f]+)
Integer 	({Binary}|{Decimal}|{Hex})
Exponent 	([Ee][+-]?[0-9]+)
Double 		([0-9]*"."[0-9]+{Exponent}?)
Bool 		("true"|"false")
String 		(\"[^"\n]*\")
Operator 	("+"|"-"|"*"|"/"|"%"|"++"|"--"|"<"|"<="|">"|">="|"="|"=="|"!="|"&&"|"!"|"||"|"&"|"|"|"^")
Bracket 	("["|"]"|"("|")"|"{"|"}")
Separator 	([ \t\n]+)
Punctuation 	(","|"."|";")
Comment 	(#[^#]*#)

%%

 /* Keyword */
"Void" 		{ printf("(Keyword 	, %d(VOID) 	)\n", VOID); 		 return VOID; 	}
"int" 		{ printf("(Keyword  	, %d(int) 	)\n", INT); 		 return INT; 	}
"double" 	{ printf("(Keyword 	, %d(double) 	)\n", DOUBLE); 		 return DOUBLE; }
"bool" 		{ printf("(Keyword 	, %d(bool) 	)\n", BOOL); 		 return BOOL; 	}
"string" 	{ printf("(Keyword 	, %d(string) 	)\n", STRING); 		 return STRING; }
"class" 	{ printf("(Keyword 	, %d(class)	)\n", CLASS); 		 return CLASS; 	}
"interface" 	{ printf("(Keyword 	, %d(interface)	)\n", INTERFACE); 	 return INTERFACE;}
"null" 		{ printf("(Keyword 	, %d(null)	)\n", _NULL); 		 return _NULL; 	}
"this" 		{ printf("(Keyword  	, %d(this)	)\n", THIS); 		 return THIS; 	}
"extends" 	{ printf("(Keyword 	, %d(extends)	)\n", EXTENDS); 	 return EXTENDS; }
"implements" 	{ printf("(Keyword 	, %d(implements))\n", IMPLEMENTS); 	 return IMPLEMENTS;}
"for" 		{ printf("(Keyword 	, %d(for)	)\n", FOR); 		 return FOR; 	}
"while" 	{ printf("(Keyword 	, %d(while)	)\n", WHILE); 		 return WHILE; 	}
"if" 		{ printf("(Keyword 	, %d(if)	)\n", IF); 		 return IF; 	}
"else" 		{ printf("(Keyword 	, %d(else)	)\n", ELSE); 		 return ELSE;  	}
"return" 	{ printf("(Keyword 	, %d(return)	)\n", RETURN); 		 return RETURN; }
"break" 	{ printf("(Keyword 	, %d(break)	)\n", BREAK); 		 return BREAK; 	}
"continue" 	{ printf("(Keyword 	, %d(continue)	)\n", CONTINUE); 	 return CONTINUE;}
"new" 		{ printf("(Keyword 	, %d(new)	)\n", NEW); 		 return NEW; 	}
"array" 	{ printf("(Keyword	, %d(array)	)\n", ARRAY); 		 return ARRAY; 	}
"print" 	{ printf("(Keyword 	, %d(print)	)\n", PRINT); 		 return PRINT; 	}
"readint" 	{ printf("(Keyword 	, %d(readint)	)\n", READINT); 	 return READINT;}
"readline" 	{ printf("(Keyword 	, %d(readline)	)\n", READLINE ); 	 return READLINE;}

 /* Operators */
"+" 		{ printf("(Operator	, %d(+)		)\n", ADD); 		return ADD; 	}
"-" 		{ printf("(Operator 	, %d(-)		)\n", MINUS); 		return MINUS; 	}
"*" 		{ printf("(Operator 	, %d(*)		)\n", MULTIPLY); 	return MULTIPLY;}
"/" 		{ printf("(Operator 	, %d(/)		)\n", DIVIDE); 		return DIVIDE; 	}
"%" 		{ printf("(Operator  	, %d(%%)	)\n", MOD); 		return MOD; 	}
"++" 		{ printf("(Operator	, %d(++)	)\n", SELFINC); 	return SELFINC; }
"--" 		{ printf("(Operator 	, %d(--)	)\n", SELFDEC); 	return SELFDEC; }
"<" 		{ printf("(Operator 	, %d(<)		)\n", LESS); 		return LESS; 	}
"<=" 		{ printf("(Operator 	, %d(<=)	)\n", LESSEQUAL); 	return LESSEQUAL;}
">" 		{ printf("(Operator 	, %d(>)		)\n", GREATER); 	return GREATER; }
">=" 		{ printf("(Operator 	, %d(>=)	)\n", GREATEREQUAL); 	return GREATEREQUAL;}
"=" 		{ printf("(Operator 	, %d(=)		)\n", ASSIGN); 		return ASSIGN; 	}
"==" 		{ printf("(Operator 	, %d(==)	)\n", EQUAL); 		return EQUAL; 	}
"!=" 		{ printf("(Operator 	, %d(!=)	)\n", UNEQUAL); 	return UNEQUAL; }
"&&" 		{ printf("(Operator  	, %d(&&)	)\n", AND); 		return AND; 	}
"||" 		{ printf("(Operator 	, %d(||)	)\n", OR); 		return OR; 	}
"!" 		{ printf("(Operator 	, %d(!)		)\n", NOT); 		return NOT; 	}
"&" 		{ printf("(Operator 	, %d(&)		)\n", BITAND); 		return BITAND; 	}
"|" 		{ printf("(Operator 	, %d(|)		)\n", BITOR); 		return BITOR; 	}
"^" 		{ printf("(Operator 	, %d(^)		)\n", BITXOR); 		return BITXOR; 	}

 /* Comment */
{Comment} 	{ 					}
 /* Separator */
{Separator} 	{ if(yytext[0] == '\n') line++; 	}	
{Punctuation} 	{ printf("(Punctuation 	, %d(%c) 	)\n", yytext[0], yytext[0]); 	return yytext[0]; 	}

 /* Bracket */
{Bracket} 	{ printf("(Bracket 	, %d(%c) 	)\n", yytext[0], yytext[0]); 	return yytext[0]; 	}

 /* Constants */
{Binary} 	{ yylval.integerConstant = strtol(yytext, NULL, 2); 	printf("(IntegerConst 	, %d 		)\n", yylval.integerConstant); 	return INTEGERCONST; 	}
{Decimal} 	{ yylval.integerConstant = strtol(yytext, NULL, 10); 	printf("(IntegerConst 	, %d 		)\n", yylval.integerConstant); 	return INTEGERCONST; 	}
{Hex} 		{ yylval.integerConstant = strtol(yytext, NULL, 16); 	printf("(IntegerConst 	, %d 		)\n", yylval.integerConstant); 	return INTEGERCONST; 	}
{Double} 	{ yylval.doubleConstant = atof(yytext); 		printf("(DoubleConst 	, %lf 		)\n", yylval.doubleConstant); 	return DOUBLECONST; 	}
{String} 	{ strcpy(yylval.stringConstant, yytext); 		printf("(StringConst 	, \"%s\" 	)\n", yylval.stringConstant);  	return STRINGCONST; 	}
{Bool} 		{ 
		yylval.boolConstant = (yytext[0] == 't');
		if(yylval.boolConstant)
			printf("(BoolConst 	, true 		)\n");
		else
			printf("(BoolConst 	, false 	)\n");
		return BOOLCONST;
}

 /* Identifier */
{Identifier} 	{
	if (strlen(yytext) > MAX_IDENTIFIER_LENGTH){
		printf("\nToo Long Identifier!\n");
		return -1;
	}
	strcpy(yylval.identifier, yytext);
	yylval.identifier[MAX_IDENTIFIER_LENGTH] = '\0';
	printf("(Identifier 	, %s 	)\n", yylval.identifier);
	return IDENTIFIER;
}

. 		{ err++; printf("Line %d : Error Type, NO Matching Pattern - %s\n", line, yytext); return -1; 	}

%%

int main(int argc, char *argv[]){
	int ret;
	if(argc == 2)
		freopen(argv[1], "r", stdin);
	else if(argc != 1 ){
		printf("Check your arguments!\n");
		exit(0);
	}
	while((ret = yylex()))
		;
	printf("\n# of lexical errors: %d\n\n", err);
	return 0;
}
