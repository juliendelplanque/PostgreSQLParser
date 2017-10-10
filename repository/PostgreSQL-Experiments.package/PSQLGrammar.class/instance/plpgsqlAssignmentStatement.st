plpgsql
plpgsqlAssignmentStatement
	^ plpgsqlAssignmentLeftPart trim , (':=' asParser / $= asParser) trim , (plpgsqlCompositeValue / expression)