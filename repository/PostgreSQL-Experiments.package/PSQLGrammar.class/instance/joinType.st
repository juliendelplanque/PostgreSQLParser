keywords
joinType
	^ (inner trim optional, join trim) /
	(left trim , outer trim optional , join trim) /
	(right trim , outer trim optional , join trim) /
	(full trim , outer trim optional , join trim) /
	(cross trim , join trim)