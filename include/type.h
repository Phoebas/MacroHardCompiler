#ifndef _TYPE_H

#define _TYPE_H

#ifndef YYTOKENTYPE
#define YYTOKENTYPE

enum yytokentype {
	VOID =  	258, 		// ATTENTION: Any Type CANNOT Be Defined to ZERO.
	INT =  		259,
	DOUBLE =  	260,
	BOOL =  	261,
	STRING =  	262,
	CLASS = 	263,
	INTERFACE =  	264,
	_NULL =  	265,
	THIS =  	266,
	EXTENDS =  	267,
	IMPLEMENTS =  	268,
	FOR =  		269,
	WHILE =  	270,
	IF =  		271,
	ELSE =   	272,
	RETURN =  	273,
	BREAK =  	274,
	CONTINUE = 	275,
	NEW =  		276,
	ARRAY =  	277,
	PRINT =  	278,
	READINT =  	279,
	READLINE =  	280,

	ADD =  		43, 		// The ASCII of '+' is 43
	MINUS =  	45, 		// The ASCII of '-' is 45
	MULTIPLY =  	42, 		// The ASCII of '*' is 42
	DIVISE =  	47, 		// The ASCII of '/' is 47
	MOD =  		37, 		// The ASCII of '%' is 37
	SELFINC =  	281,
	SELFDEC =  	282,
	LESS =  	60, 		// The ASCII of '<' is 60
	LESSEQUAL =  	283,
	GREATER =  	62, 		// The ASCII of '>' is 62
	GREATEREQUAL = 	284,
	ASSIGN =  	61, 		// The ASCII of '=' is 61
	EQUAL =  	285,
	UNEQUAL =  	286,
	AND =  		287,
	OR =  		288,
	NOT =  		33, 		// The ASCII of '!' is 33
	
	// 		40 and 41 should be reserved for ( and ), 91 and 93 also for [ and ], 123 and 125 also for { and }
	
	BITAND =  	38, 		// The ASCII of '&' is 38
	BITOR =  	124, 		// The ASCII of '|' is 124
	BITXOR = 	94, 		// The ASCII of '^' is 94

	// 		44, 46, 59 shuold be reserved for , . ;
	
	BOOLCONST = 	289,
	INTEGERCONST = 	290,
	DOUBLECONST = 	291,
	STRINGCONST = 	292,
	IDENTIFIER = 	293,
	
};

#endif

#endif
