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

#define MAX_IDENTIFIER_LENGTH 32

%}

%s NORMAL
%x COPY COMMENTS
%option stack

/* Definition */
Identifier 	([A-Za-z][A-Za-z_0-9]*)
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
Comma 		(";")
Comment 	{"//"[^]*"\n")

%%

 /* Keyword */
"void" 		{ printf("(void 		, Keyword 	)\n"); return Void; 	}
"int" 		{ printf("(int 			, Keyword  	)\n"); return Int; 	}
"double" 	{ printf("(double 		, Keyword 	)\n"); return Double; 	}
"bool" 		{ printf("(bool 		, Keyword 	)\n"); return Bool; 	}
"string" 	{ printf("(string 		, Keyword 	)\n"); return String; 	}
"class" 	{ printf("(class 		, Keyword 	)\n"); return Class; 	}
"interface" 	{ printf("(interface 		, Keyword 	)\n"); return Interface;}
"null" 		{ printf("(null 		, Keyword 	)\n"); return Null; 	}
"this" 		{ printf("(this 		, Keyword  	)\n"); return This; 	}
"extends" 	{ printf("(extends 		, Keyword 	)\n"); return Extends; 	}
"implements" 	{ printf("(implements 		, Keyword 	)\n"); return Implements; 	}
"for" 		{ printf("(for 			, Keyword 	)\n"); return For; 	}
"while" 	{ printf("(while 		, Keyword 	)\n"); return While; 	}
"if" 		{ printf("(if 			, Keyword 	)\n"); return If; 	}
"else" 		{ printf("(else 		, Keyword 	)\n"); return Else;  	}
"return" 	{ printf("(return 		, Keyword 	)\n"); return Return; 	}
"break" 	{ printf("(break 		, Keyword 	)\n"); return Break; 	}
"new" 		{ printf("(new 			, Keyword 	)\n"); return New; 	}
"array" 	{ printf("(array 		, Keyword	)\n"); return Array; 	}
"print" 	{ printf("(print 		, Keyword 	)\n"); return Print; 	}
"readinteger" 	{ printf("(readinteger 		, Keyword 	)\n"); return ReadInteger;	}
"readline" 	{ printf("(readline 		, Keyword 	)\n"); return ReadLine; }

 /* Operators */
"+" 		{ printf("(add, 		, Operator	)\n"); return Add; 	}
"-" 		{ printf("(minus 		, Operator 	)\n"); return Minus; 	}
"*" 		{ printf("(multiply 		, Operator 	)\n"); return Multiply; }
"/" 		{ printf("(divise 		, Operator 	)\n"); return Divise; 	}
"%" 		{ printf("(mod 			, Operator  	)\n"); return Mod; 	}
"++" 		{ printf("(selfinc 		, Operator	)\n"); return SelfInc; 	}
"--" 		{ printf("(selfdec 		, Operator 	)\n"); return selfDec; 	}
"<" 		{ printf("(less 		, Operator 	)\n"); return Less; 	}
"<=" 		{ printf("(lessequal 		, Operator 	)\n"); return LessEqual;}
">" 		{ printf("(greater 		, Operator 	)\n"); return Greater; 	}
">=" 		{ printf("(greaterequal 	, Operator 	)\n"); return GreaterEqual;}
"=" 		{ printf("(assign 		, Operator 	)\n"); return Assign; 	}
"==" 		{ printf("(equal 		, Operator 	)\n"); return Equal; 	}
"!=" 		{ printf("(unequal 		, Operator 	)\n"); return Unequal; 	}
"&&" 		{ printf("(and 			, Operator  	)\n"); return And; 	}
"||" 		{ printf("(or 			, Operator 	)\n"); return Or; 	}
"!" 		{ printf("(not 			, Operator 	)\n"); return Not; 	}
"&" 		{ printf("(bitand 		, Operator 	)\n"); return BitAnd; 	}
"|" 		{ printf("(bitor 		, Operator 	)\n"); return BitOr; 	}

 /* Separator */
{Separator} 	{ 						}
{Comma} 	{ return Comma; 				}

 /* Bracket */
{Bracket} 	{ printf("(%c 		, Bracket 	)\n", yytext[0]); 	 return yytext[0]; 	}

 /* Constants */
{Binary} 	{ yylval.integerConstant = strtol(yytext, NULL, 2); 	printf("(%d 		, IntegerConst 	)\n", yylval.integerConstant); 	return IntegerConst; 	}
{Decimal} 	{ yylval.integerConstant = strtol(yytext, NULL, 10); 	printf("(%d 		, IntegerConst 	)\n", yylval.integerConstant); 	return IntegerConst; 	}
{Hex} 		{ yylval.integerConstant = strtol(yytext, NULL, 16); 	printf("(%d 		, IntegerConst 	)\n", yylval.integerConstant); 	return IntegerConst; 	}
{Double} 	{ yylval.doubleConstant = atof(yytext); 		printf("(%lf 		, DoubleConst 	)\n", yylval.doubleConstant); 	return DoubleConst; 	}
{String} 	{ strcpy(yylval.stringConstant, yytext); 		printf("(\"%s\", 	, StringConst 	)\n", yylval.stringConstant);  	return StringConst; 	}
{Bool} 		{ 
		yylval.boolConstant = (yytext[0] == 't');
		if(yylval.boolConstant)
			printf("(true 		, BoolConst 	)\n");
		else
			printf("(false 		, BoolConst 	)\n");
		return BoolConst;
}

 /* Identifier */
{Identifier} 	{
	if (strlen(yytext) > MAX_IDENTIFIER_LENGTH){
		printf("\nToo Long Identifier\n");
		return -1;
	}
	strcpy(yylval.identifier, yytext);
	yylval.identifier[MAX_IDENTIFIER_LENGTH] = '\0';
	printf("(%s 		, Identifier 	)\n", yylval.identifier);
	return Identifier;
}

%%

