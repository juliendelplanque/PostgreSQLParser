plpgsql
plpgsqlCursorDeclaration
	"name [ [ NO ] SCROLL ] CURSOR [ ( arguments ) ] FOR query"
	^ identifier trim , (kw no trim optional , kw scroll) trim optional , kw cursor trim ,
	(openParenthesis trim , 
		((identifier trim , identifierOrKeyword trim plus) plus separatedBy: comma trim) , 
	closeParenthesis trim) trim optional ,
	kw for trim , selectCommand