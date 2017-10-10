plpgsql
plpgsqlAssignmentStatement
	^ plpgsqlAssignmentLeftPart trim , (':=' asParser / $= asParser) trim , expression