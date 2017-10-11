select command
joinType
	^ (kw inner trim optional, kw join trim) /
	(kw left trim , kw outer trim optional , kw join trim) /
	(kw right trim , kw outer trim optional , kw join trim) /
	(kw full trim , kw outer trim optional , kw join trim) /
	(kw cross trim , kw join trim)