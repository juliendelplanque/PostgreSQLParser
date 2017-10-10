plpgsql
plpgsqlAssignmentStatement
	^ (identifier , ($. asParser , identifier) star) trim , (':=' asParser / $= asParser) trim , expression