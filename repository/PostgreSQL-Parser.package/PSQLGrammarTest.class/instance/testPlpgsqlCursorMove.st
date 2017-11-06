tests-plpgsql
testPlpgsqlCursorMove
	self
		parse: 'MOVE curs1' rule: #plpgsqlCursorMove;
		parse: 'MOVE LAST FROM curs3' rule: #plpgsqlCursorMove;
		parse: 'MOVE RELATIVE -2 FROM curs4' rule: #plpgsqlCursorMove;
		parse: 'MOVE FORWARD 2 FROM curs4' rule: #plpgsqlCursorMove