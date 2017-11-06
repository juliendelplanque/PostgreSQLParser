plpgsql
plpgsqlOpenCursorForQuery
	"OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR query"
	^ kw open trim , identifier trim , 
		(kw no trim optional , kw scroll trim) trim optional ,
		kw for trim , 
		selectCommand trim