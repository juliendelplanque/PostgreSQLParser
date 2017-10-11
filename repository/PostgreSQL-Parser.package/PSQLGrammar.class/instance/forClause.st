select command
forClause
	^ kw for trim , (kw update trim / kw share trim) , (kw of trim , (expression plus separatedBy: comma trim)) optional , kw nowait trim optional