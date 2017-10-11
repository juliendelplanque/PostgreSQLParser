plpgsql
plpgsqlReturn
	"RETURN expression | 
	 RETURN NEXT expression |
	 RETURN QUERY query |
	 RETURN QUERY EXECUTE command-string [ USING expression [, ... ] ] |
	 RETURN"
	^ plpgsqlReturnForm1 /
	plpgsqlReturnForm2 /
	plpgsqlReturnForm3 /
	(return trim , query trim , execute trim , stringConstant trim , (using trim , (expression plus separatedBy: comma trim)) optional) /
	return