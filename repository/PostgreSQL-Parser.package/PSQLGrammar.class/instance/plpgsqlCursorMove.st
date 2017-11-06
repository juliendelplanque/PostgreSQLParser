plpgsql
plpgsqlCursorMove
	"MOVE [ direction { FROM | IN } ] cursor"
	kw move trim ,
	(plpgsqlMoveCursorDirection trim , (kw from / kw in)) trim optional ,
	identifier