select command
withClause
	^ with trim , recursive trim optional , (withQuery separatedBy: comma trim)