accessing
havingClause
	^ kw having trim , (expression plus separatedBy: comma trim)