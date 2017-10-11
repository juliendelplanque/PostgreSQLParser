select command
unionIntersectExceptClause
	^ (kw union trim / kw intersect trim / kw except trim) , (kw all trim / kw distinct trim) optional , selectCommand trim