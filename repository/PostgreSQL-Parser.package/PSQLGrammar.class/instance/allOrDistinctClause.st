accessing
allOrDistinctClause
	"ALL | DISTINCT [ ON ( expression [, ...] ) ]"
	^ kw all trim /
	(kw distinct trim , 
		(kw on trim ,
			openParenthesis trim ,
			(expression plus separatedBy: comma trim) ,
			closeParenthesis trim
		) optional
	)