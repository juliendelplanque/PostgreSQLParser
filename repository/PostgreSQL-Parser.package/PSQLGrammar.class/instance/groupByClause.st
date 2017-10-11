accessing
groupByClause
	^ kw group trim , kw by trim , (expression plus separatedBy: comma trim)