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

%}

%token Void Bol Int Double String New Array
%token Class Interface Extends Implements This Null
%token Add Minus Multiply Divise Mod SelfInc SelfDec
%token Equal GreatEqual Equal Unequal Less LessEqual Assign
%token And Or Not BitAnd BitOr BitXor
%token For While If Else Return Break Continue
%token Identifier BoolConst IntegerConst DoubleConst StringConst
%token Print ReadInt ReadLine

/* terminal */
%token <identifier> 	Identifier
%token <stringConst> 	StringConst
%token <integerConst> 	IntegerConst
%token <doubleConst> 	DoubleConst
%token <boolConst> 	BoolConst

/* non-terminal */
%token <expression> 	Const Expr Call
%token <lvalue> 	LValue
%token <type> 		Type

%%

Program 	: Declaration+

Declaration 	: Var
		| Func
		| Class
		| Interface

Type 		| Int
		| Double
		| String

Var 		: Type Identifier
Identifier 	: 
