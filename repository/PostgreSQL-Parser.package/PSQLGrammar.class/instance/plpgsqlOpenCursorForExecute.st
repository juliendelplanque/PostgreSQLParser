plpgsql
plpgsqlOpenCursorForExecute
	"OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR EXECUTE query_string [ USING expression [, ... ] ]"
	^ kw open trim , identifier trim ,
		(kw no trim optional , kw scroll trim) trim optional ,
		kw for trim , kw execute trim , expression trim , "This expression has to lead to a String"
		(kw using trim , (expression plus separatedBy: comma trim)) optional