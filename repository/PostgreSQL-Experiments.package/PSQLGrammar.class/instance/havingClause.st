accessing
havingClause
	^ having trim , (expression plus separatedBy: comma trim)