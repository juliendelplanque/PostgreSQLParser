select command
unionIntersectExceptClause
	^ (union trim / intersect trim / except trim) , (all trim / distinct trim) optional , selectCommand trim