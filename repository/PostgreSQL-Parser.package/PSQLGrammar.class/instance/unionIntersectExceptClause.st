select command
unionIntersectExceptClause
	^ (union trim / intersect trim / except trim) , (kw all trim / distinct trim) optional , selectCommand trim