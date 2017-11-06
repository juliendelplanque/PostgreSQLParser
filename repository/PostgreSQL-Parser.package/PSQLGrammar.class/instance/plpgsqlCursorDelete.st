plpgsql
plpgsqlCursorDelete
	"DELETE FROM table WHERE CURRENT OF cursor"
	^ kw delete trim , kw from trim , identifier trim , kw whereKeyword trim , kw current trim , kw of trim , identifier