enum yytokentype {
	Void =  	258, 		// ATTENTION: Any Type CANNOT Be Defined to ZERO.
	Int =  		259,
	Double =  	260,
	Bool =  	261,
	String =  	262,
	Class = 	263,
	Interface =  	264,
	Null =  	265,
	This =  	266,
	Extends =  	267,
	Implements =  	268,
	For =  		269,
	While =  	270,
	If =  		271,
	Else =   	272,
	Return =  	273,
	Break =  	274,
	Continue = 	275,
	New =  		276,
	Array =  	277,
	Print =  	278,
	ReadInt =  	279,
	ReadLine =  	280,

	Add =  		43, 		// The ASCII of '+' is 43
	Minus =  	45, 		// The ASCII of '-' is 45
	Multiply =  	42, 		// The ASCII of '*' is 42
	Divise =  	47, 		// The ASCII of '/' is 47
	Mod =  		37, 		// The ASCII of '%' is 37
	SelfInc =  	281,
	SelfDec =  	282,
	Less =  	60, 		// The ASCII of '<' is 60
	LessEqual =  	283,
	Greater =  	62, 		// The ASCII of '>' is 62
	GreaterEqual = 	284,
	Assign =  	61, 		// The ASCII of '=' is 61
	Equal =  	285,
	Unequal =  	286,
	And =  		287,
	Or =  		288,
	Not =  		33, 		// The ASCII of '!' is 33
	
	// 		40 and 41 should be reserved for ( and ), 91 and 93 also for [ and ], 123 and 125 also for { and }
	
	BitAnd =  	38, 		// The ASCII of '&' is 38
	BitOr =  	124, 		// The ASCII of '|' is 124
	BitXor = 	94, 		// The ASCII of '^' is 94

	// 		44, 46, 59 shuold be reserved for , . ;
	
	BoolConst = 	289,
	IntegerConst = 	290,
	DoubleConst = 	291,
	StringConst = 	292,
	Identifier = 	293,
	
};
