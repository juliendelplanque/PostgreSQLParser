plpgsql
plpgsqlAssignmentStatement
	^ (identifier , ($. asParser , identifier) star) trim , ':=' asParser trim , expression