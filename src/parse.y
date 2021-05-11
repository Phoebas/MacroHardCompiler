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
	Variable variable;
}

/* terminal without value */
%token VOID BOOL INT DOUBLE STRING NEW ARRAY
%token CLASS INTERFACE EXTENDS IMPLEMENTS THIS _NULL
%token ADD MINUS MULTIPLY DIVIDE MOD SELFINC SELFDEC
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
%type <statements> 		stmt block
%type <statement> 		if while for break continue input output
%type <expression> 		constant expr call assign
%type <lvalue> 			lvalue
%type <type> 			type
%type <decl>  			declaration classdecl funcdecl vardecl field
%type <decls> 			declarations vars formals fields exprs parameters 
%type <variable> 		var 

/* precedence and associativity */
%left 		','
%right 		ASSIGN
%left 		OR
%left 		AND
%left 		BITOR
%left 		BITXOR
%left 		BITAND
%left 		UNEQUAL
%left 		EQUAL
%left  		GREATER GREATEREQUAL LESS LESSEQUAL
%left 		ADD MINUS
%left 		MULTIPLY DIVIDE MOD
%right 		NEGATIVE NOT SELFINC SELFDEC
%left 		'.' '['

%nonassoc 	DOT

%nonassoc 	LOWER_THAN_ELSE
%nonassoc 	ELSE

%%

program 	: declarations
		;

declarations 	: declaration
	      	| declarations declaration
		;

declaration 	: funcdecl
		| vardecl
		| classdecl
		;

type 		: INT
		| DOUBLE
		| STRING
		| BOOL
		;

vardecl 	: type vars ';'
	 	;

vars 		: var
       		| vars ',' var
		;

var 		: IDENTIFIER
      		| IDENTIFIER '[' INTEGERCONST ']'
		;

formal 		: type IDENTIFIER
	 	;

formals 	: formal
	 	| formals ',' formal
		;

funcdecl 	: type IDENTIFIER '(' formals ')' block
		| VOID IDENTIFIER '(' formals ')' block
		;

field 		: vardecl
		| funcdecl
		;

fields 		: field
	 	| fields field
		;

classdecl 	: CLASS IDENTIFIER '{' fields '}'
		;

lvalue 		: IDENTIFIER
		| IDENTIFIER '.' IDENTIFIER 	%prec DOT
		| IDENTIFIER '[' expr ']'
		;

assign 		: lvalue ASSIGN expr ';'
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
		| expr ADD expr
		| expr MINUS expr
		| expr MULTIPLY expr
		| expr DIVIDE expr
		| expr MOD expr
		| NEGATIVE expr
		| expr LESS expr
		| expr LESSEQUAL expr
		| expr GREATER expr
		| expr GREATEREQUAL expr
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

stmt 		: expr ';'
		| if
		| while
		| for
		| break
		| continue
		| return
		| output
		| block
		;

stmts 		: stmt
		| stmts stmt
		;

block 		: '{' stmts '}'
		;

if 		: IF '(' expr ')' stmt 		%prec LOWER_THAN_ELSE
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

output 		: PRINT '(' exprs ')' ';'
	 	;

exprs 		: expr
		| exprs ',' expr
		; 

parameters 	: 
	    	| exprs
		;

call 		: IDENTIFIER '(' parameters ')'
       		| IDENTIFIER '.' IDENTIFIER '(' parameters ')'
		;

%%

int yyerror(char *s){
	fprintf(stderr, "error: %s", s);
	return 0;
}
