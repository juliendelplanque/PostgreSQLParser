accessing
allOrDistinctClause
	"ALL | DISTINCT [ ON ( expression [, ...] ) ]"
	^ kw all trim /
	(distinct trim , 
		(on trim ,
			openParenthesis trim ,
			(expression plus separatedBy: comma trim) ,
			closeParenthesis trim
		) optional
	)