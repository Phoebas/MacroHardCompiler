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

#include "type.h"
#include "yylval.h"

extern union lval yylval;

%}

/* terminal without value */
%token VOID BOL INT DOUBLE STRING NEW ARRAY
%token CLASS INTERFACE EXTENDS IMPLEMENTS THIS _NULL
%token ADD MINUS MULTIPLY DIVISE MOD SELFINC SELFDEC
%token EQUAL GREATEQUAL EQUAL UNEQUAL LESS LESSEQUAL ASSIGN
%token AND OR NOT BITAND BITOR BITXOR
%token FOR WHILE IF ELSE RETUAN BREAK CONTINUE
%token PRINT READINT READLINE

/* terminal with value */
%token <identifier> 		IDENTIFIER
%token <stringConstant> 	STRINGCONST
%token <integerConstant> 	INTEGERCONST
%token <doubleConstant> 	DOUBLECONST
%token <boolConstant> 		BOOLCONST

/* non-terminal */
%token <expression> 		const expr call
%token <lvalue> 		lvalue
%token <type> 			type
%token <declaration>  		classDecl decl fild intfDecl
%token <functionDeclaration> 	funcDecl frncHeader
%token <declarationList> 	filedList declList intfList
%token <variableDeclaration> 	var varDecl

%%

program 	: declarations
		;

declarations 	: vars
		| funcs
		| classes
		| interfaces
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
		| void IDENTIFIER '(' formals ')' block
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
		| expr.IDENTIFIER
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

continue 	: CONTINUE ';'
	  	;

input 		: READINTEGER '(' ')' ';'
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
       		| expr.IDENTIFIER '(' parameters ')'
		;

