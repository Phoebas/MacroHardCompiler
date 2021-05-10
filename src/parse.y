/**
 * @file MacroHard.y
 * @brief The yacc file to generate the parser for MacroHard
 *
 * @details
 * build AST from tokens
 *
 * @date 2021-04-27
 * @author Yongkang Li
**/

%{

#include "yylval.h"
#include "lex.yy.c"

extern YYSTYPE yylval;

extern int yylex(void);

int yyerror(char *s);

%}

%union {
	int integerConstant;
	char stringConstant[1024];
	char identifier[32];
	double doubleConstant;
	bool boolConstant;
	Statement statement;
	Expression expression;
	Lvalue lvalue;
	Type type;
	Decl decl;
	Decls decls;
	MoreDecl moredecl;
	Params params;
	Variable variable;
}

/* terminal without value */
%token VOID BOOL INT DOUBLE STRING NEW ARRAY
%token CLASS INTERFACE EXTENDS IMPLEMENTS THIS _NULL
%token ADD MINUS MULTIPLY DIVISE MOD SELFINC SELFDEC
%token GREATEQUAL EQUAL UNEQUAL LESS LESSEQUAL ASSIGN
%token AND OR NOT BITAND BITOR BITXOR
%token FOR WHILE IF ELSE RETURN BREAK CONTINUE
%token PRINT READINT READLINE

/* terminal with value */
%token <identifier> 		IDENTIFIER
%token <stringConstant> 	STRINGCONST
%token <integerConstant> 	INTEGERCONST
%token <doubleConstant> 	DOUBLECONST
%token <boolConstant> 		BOOLCONST

/* non-terminal */
%type <statement> 		program stmt block if while for break continue input output
%type <expression> 		constant expr call assign
%type <lvalue> 			lvalue
%type <type> 			type
%type <decl>  			class field
%type <decls> 			vars funcs classes
%type <moredecl> 		declarations moreid morevars morefields morestmts moreexprs
%type <params> 			formals parameters
%type <variable> 		var 

%%

program 	: declarations
		;

declarations 	: 
	      	| vars declarations
		| funcs declarations
		| classes declarations
		;

type 		: INT
		| DOUBLE
		| STRING
		;

vars		: type IDENTIFIER moreids ';'
      		| type IDENTIFIER '[' INTEGERCONST ']' moreids ';'
		;

moreids 	: 
	  	| ',' IDENTIFIER moreids
		| ',' IDENTIFIER '[' INTEGERCONST ']' moreids
		;

formals 	: type IDENTIFIER morevars
	 	;

morevars 	:
	 	| ',' type IDENTIFIER morevars
		;

func 		: type IDENTIFIER '(' formals ')' block
		| VOID IDENTIFIER '(' formals ')' block
		;

funcs 		:
		| func funcs
		;

field 		: type IDENTIFIER ';'
		| func
		;

class 		: CLASS IDENTIFIER '{' field morefields '}'
		;

morefields 	: 
	    	| field morefields
		;

classes 	:
		|  class classes
	 	;

lvalue 		: 
	 	| IDENTIFIER
		| expr '.' IDENTIFIER
		| expr '[' expr ']'
		;

assign 		: lvalue '=' expr ';'
	 	;

constant 	: INTEGERCONST
	  	| BOOLCONST
		| DOUBLECONST
		| STRINGCONST
		| _NULL
		;

expr 		: assign
       		| constant
		| lvalue
		| lvalue SELFINC
		| SELFINC lvalue
		| lvalue SELFDEC
		| SELFDEC lvalue
		| THIS
		| call
		| '(' expr ')'
		| expr '+' expr
		| expr '-' expr
		| expr '*' expr
		| expr '/' expr
		| expr '%' expr
		| '-' expr
		| expr '<' expr
		| expr LESSEQUAL expr
		| expr '>' expr
		| expr GREATEQUAL expr
		| expr EQUAL expr
		| expr UNEQUAL expr
		| expr AND expr
		| expr OR expr
		| NOT expr
		| expr BITAND expr
		| expr BITOR expr
		| expr BITXOR expr
		| input
		| NEW IDENTIFIER
		;

stmt 		: ';'
       		| expr ';'
		| if
		| while
		| for
		| break
		| continue
		| return
		| output
		| block
		;

block 		: '{' stmt morestmts '}'
		;

morestmts 	: 
	   	| stmt morestmts 
		;

if 		: IF '(' expr ')' stmt
     		| IF '(' expr ')' stmt ELSE stmt
		;

while 		: WHILE '(' expr ')' stmt
		;

for 		: FOR '(' ';' ';' ')' stmt
      		| FOR '(' expr ';' ';' ')' stmt
		| FOR '(' ';' expr ';' ')' stmt
		| FOR '(' ';' ';' expr ')' stmt
		| FOR '(' ';' expr ';' expr ')' stmt
		| FOR '(' expr ';' ';' expr ')' stmt
		| FOR '(' expr ';' expr ';' ')' stmt
		| FOR '(' expr ';' expr ';' expr ')' stmt

break 		: BREAK ';'
		;

return 		: RETURN expr ';'
	 	;

continue 	: CONTINUE ';'
	  	;

input 		: READINT '(' ')' ';'
		| READLINE '(' ')' ';'
		;

output 		: PRINT '(' expr moreexprs ')' ';'
	 	;

moreexprs 	:
	   	| ',' expr moreexprs
		;

parameters 	: 
	    	| expr moreexprs
		;

moreexprs 	: 
	   	| ',' expr moreexprs
		;

call 		: IDENTIFIER '(' parameters ')'
       		| expr '.' IDENTIFIER '(' parameters ')'
		;

%%

int yyerror(char *s){
	fprintf(stderr, "error: %s", s);
	return 0;
}
