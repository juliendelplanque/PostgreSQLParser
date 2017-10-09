create table command
createTableWithClauseInheritsClause
	^ inherits trim , openParenthesis trim , (identifier plus separatedBy: comma trim) , closeParenthesis trim