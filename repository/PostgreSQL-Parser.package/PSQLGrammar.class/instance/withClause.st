as yet unclassified
withClause
	^ kw with trim , kw recursive trim optional , (withQuery separatedBy: comma trim)