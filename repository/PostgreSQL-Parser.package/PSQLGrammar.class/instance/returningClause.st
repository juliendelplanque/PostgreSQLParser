insert command
returningClause
	"RETURNING * | output_expression [ [ AS ] output_name ] [, ...]"
	
	^ kw returning trim ,
		($* asParser / 
		(((expression trim , (kw as trim optional , identifier) optional)) plus separatedBy: comma trim))