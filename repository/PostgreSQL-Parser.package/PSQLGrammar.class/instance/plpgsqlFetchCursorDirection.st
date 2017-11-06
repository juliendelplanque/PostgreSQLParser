plpgsql
plpgsqlFetchCursorDirection
	"NEXT | PRIOR | FIRST | LAST | ABSOLUTE count | RELATIVE count | FORWARD | BACKWARD"
	^ kw next / 
	kw prior / 
	kw first / 
	kw last / 
	(kw absolute trim , ($- asParser optional , numericConstant)) / 
	(kw relative trim , ($- asParser optional , numericConstant)) / 
	kw forward / 
	kw backward