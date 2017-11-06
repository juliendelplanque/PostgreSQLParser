plpgsql
plpgsqlCursorFetch
	"FETCH [ direction { FROM | IN } ] cursor INTO target"
	^ kw fetch trim , 
	(plpgsqlFetchCursorDirection trim , (kw from / kw in)) trim optional ,
	identifier trim , kw into trim , (identifier plus separatedBy: comma trim)