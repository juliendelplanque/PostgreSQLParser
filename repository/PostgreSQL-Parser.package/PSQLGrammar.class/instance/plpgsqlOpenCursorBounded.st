plpgsql
plpgsqlOpenCursorBounded
	"OPEN bound_cursorvar [ ( [ argument_name := ] argument_value [, ...] ) ]"
	^ kw open trim , identifier trim , 
	( openParenthesis trim , 
		(((identifier trim , ':=' asParser) trim optional , expression trim) plus separatedBy: comma trim) ,
	closeParenthesis trim ) optional