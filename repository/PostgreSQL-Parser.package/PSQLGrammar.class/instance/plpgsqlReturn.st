plpgsql
plpgsqlReturn
	"RETURN expression | 
	 RETURN NEXT expression |
	 RETURN QUERY kw query |
	 RETURN QUERY EXECUTE command-string [ USING expression [, ... ] ] |
	 RETURN"
	^ plpgsqlReturnForm1 /
	plpgsqlReturnForm2 /
	plpgsqlReturnForm3 /
	(kw return trim , kw query trim , kw execute trim , stringConstant trim , (kw using trim , (expression plus separatedBy: comma trim)) optional) /
	kw return