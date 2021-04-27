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
Comment 	{"//"[^]*"\n")

%%

 /* Keyword */
"void" 		{ printf("(Keyword 	, %d(void) 	)\n", Void); 		 return Void; 	}
"int" 		{ printf("(Keyword  	, %d(int) 	)\n", Int); 		 return Int; 	}
"double" 	{ printf("(Keyword 	, %d(double) 	)\n", Double); 		 return Double; }
"bool" 		{ printf("(Keyword 	, %d(bool) 	)\n", Bool); 		 return Bool; 	}
"string" 	{ printf("(Keyword 	, %d(string) 	)\n", String); 		 return String; }
"class" 	{ printf("(Keyword 	, %d(class)	)\n", Class); 		 return Class; 	}
"interface" 	{ printf("(Keyword 	, %d(interface)	)\n", Interface); 	 return Interface;}
"null" 		{ printf("(Keyword 	, %d(null)	)\n", Null); 		 return Null; 	}
"this" 		{ printf("(Keyword  	, %d(this)	)\n", This); 		 return This; 	}
"extends" 	{ printf("(Keyword 	, %d(extends)	)\n", Extends); 	 return Extends; }
"implements" 	{ printf("(Keyword 	, %d(implements))\n", Implements); 	 return Implements;}
"for" 		{ printf("(Keyword 	, %d(for)	)\n", For); 		 return For; 	}
"while" 	{ printf("(Keyword 	, %d(while)	)\n", While); 		 return While; 	}
"if" 		{ printf("(Keyword 	, %d(if)	)\n", If); 		 return If; 	}
"else" 		{ printf("(Keyword 	, %d(else)	)\n", Else); 		 return Else;  	}
"return" 	{ printf("(Keyword 	, %d(return)	)\n", Return); 		 return Return; }
"break" 	{ printf("(Keyword 	, %d(break)	)\n", Break); 		 return Break; 	}
"continue" 	{ printf("(Keyword 	, %d(continue)	)\n", Continue); 	 return Continue;}
"new" 		{ printf("(Keyword 	, %d(new)	)\n", New); 		 return New; 	}
"array" 	{ printf("(Keyword	, %d(array)	)\n", Array); 		 return Array; 	}
"print" 	{ printf("(Keyword 	, %d(print)	)\n", Print); 		 return Print; 	}
"readint" 	{ printf("(Keyword 	, %d(readint)	)\n", ReadInt); 	 return ReadInt;}
"readline" 	{ printf("(Keyword 	, %d(readline)	)\n", ReadLine ); 	 return ReadLine;}

 /* Operators */
"+" 		{ printf("(Operator	, %d(+)		)\n", Add); 		return Add; 	}
"-" 		{ printf("(Operator 	, %d(-)		)\n", Minus); 		return Minus; 	}
"*" 		{ printf("(Operator 	, %d(*)		)\n", Multiply); 	return Multiply;}
"/" 		{ printf("(Operator 	, %d(/)		)\n", Divise); 		return Divise; 	}
"%" 		{ printf("(Operator  	, %d(%)		)\n", Mod); 		return Mod; 	}
"++" 		{ printf("(Operator	, %d(++)	)\n", SelfInc); 	return SelfInc; }
"--" 		{ printf("(Operator 	, %d(--)	)\n", SelfDec); 	return SelfDec; }
"<" 		{ printf("(Operator 	, %d(<)		)\n", Less); 		return Less; 	}
"<=" 		{ printf("(Operator 	, %d(<=)	)\n", LessEqual); 	return LessEqual;}
">" 		{ printf("(Operator 	, %d(>)		)\n", Greater); 	return Greater; }
">=" 		{ printf("(Operator 	, %d(>=)	)\n", GreaterEqual); 	return GreaterEqual;}
"=" 		{ printf("(Operator 	, %d(=)		)\n", Assign); 		return Assign; 	}
"==" 		{ printf("(Operator 	, %d(==)	)\n", Equal); 		return Equal; 	}
"!=" 		{ printf("(Operator 	, %d(!=)	)\n", Unequal); 	return Unequal; }
"&&" 		{ printf("(Operator  	, %d(&&)	)\n", And); 		return And; 	}
"||" 		{ printf("(Operator 	, %d(||)	)\n", Or); 		return Or; 	}
"!" 		{ printf("(Operator 	, %d(!)		)\n", Not); 		return Not; 	}
"&" 		{ printf("(Operator 	, %d(&)		)\n", BitAnd); 		return BitAnd; 	}
"|" 		{ printf("(Operator 	, %d(|)		)\n", BitOr); 		return BitOr; 	}
"^" 		{ printf("(Operator 	, %d(^)		)\n", BitXor); 		return BitXor; 	}

 /* Separator */
{Separator} 	{ 						}
{Punctuation} 	{ printf("(Punctuation 	, %d(%c) 	)\n", yytext[0], yytext[0]); 	return yytext[0]; 	}

 /* Bracket */
{Bracket} 	{ printf("(Bracket 	, %d(%c) 	)\n", yytext[0], yytext[0]); 	return yytext[0]; 	}

 /* Constants */
{Binary} 	{ yylval.integerConstant = strtol(yytext, NULL, 2); 	printf("(IntegerConst 	, %d 		)\n", yylval.integerConstant); 	return IntegerConst; 	}
{Decimal} 	{ yylval.integerConstant = strtol(yytext, NULL, 10); 	printf("(IntegerConst 	, %d 		)\n", yylval.integerConstant); 	return IntegerConst; 	}
{Hex} 		{ yylval.integerConstant = strtol(yytext, NULL, 16); 	printf("(IntegerConst 	, %d 		)\n", yylval.integerConstant); 	return IntegerConst; 	}
{Double} 	{ yylval.doubleConstant = atof(yytext); 		printf("(DoubleConst 	, %d 		)\n", yylval.doubleConstant); 	return DoubleConst; 	}
{String} 	{ strcpy(yylval.stringConstant, yytext); 		printf("(StringConst 	, \"%s\" 	)\n", yylval.stringConstant);  	return StringConst; 	}
{Bool} 		{ 
		yylval.boolConstant = (yytext[0] == 't');
		if(yylval.boolConstant)
			printf("(BoolConst 	, true 		)\n");
		else
			printf("(BoolConst 	, false 	)\n");
		return BoolConst;
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
	return Identifier;
}

%%

