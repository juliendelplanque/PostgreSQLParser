tests-plpgsql
testPlpgsqlOpenCursorBounded
	self
		parse: 'OPEN curs2' rule: #plpgsqlOpenCursorBounded;
		parse: 'OPEN curs3(42)' rule: #plpgsqlOpenCursorBounded;
		parse: 'OPEN curs3(key := 42)' rule: #plpgsqlOpenCursorBounded;
		parse: 'OPEN curs3(key := 42, key2 := ''test'')' rule: #plpgsqlOpenCursorBounded