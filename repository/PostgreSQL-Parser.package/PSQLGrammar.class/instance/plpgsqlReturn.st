plpgsql
plpgsqlReturn
	"RETURN expression | 
	 RETURN NEXT expression |
	 RETURN QUERY query |
	 RETURN QUERY EXECUTE command-string [ USING expression [, ... ] ] |
	 RETURN"
	^ (return trim  , expression) /
	(return trim , next trim , expression) /
	(return trim , query trim , plpgsqlQuery) /
	(return trim , query trim , execute trim , stringConstant trim , (using trim , (expression plus separatedBy: comma trim)) optional) /
	return