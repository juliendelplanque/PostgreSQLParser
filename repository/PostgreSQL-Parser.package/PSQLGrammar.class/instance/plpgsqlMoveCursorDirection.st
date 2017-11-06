plpgsql
plpgsqlMoveCursorDirection
	"NEXT | PRIOR | FIRST | LAST | ABSOLUTE count | RELATIVE count | ALL | FORWARD [ count | ALL ] | BACKWARD [ count | ALL ]"
	^ kw next / 
	kw prior / 
	kw first / 
	kw last / 
	(kw absolute trim , ($- asParser optional , numericConstant)) / 
	(kw relative trim , ($- asParser optional , numericConstant)) / 
	kw all / 
	(kw forward trim , (kw all / ($- asParser optional , numericConstant))) / 
	(kw backward trim , (kw all / ($- asParser optional , numericConstant)))