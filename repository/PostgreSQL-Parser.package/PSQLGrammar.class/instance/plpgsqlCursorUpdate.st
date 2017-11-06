plpgsql
plpgsqlCursorUpdate
	"UPDATE table SET ... WHERE CURRENT OF cursor"
	^ kw update trim , identifier trim , kw set trim , 
	((identifier trim , $= asParser trim , expression) plus separatedBy: comma trim) ,
	kw whereKeyword trim , kw current trim , kw of trim , identifier