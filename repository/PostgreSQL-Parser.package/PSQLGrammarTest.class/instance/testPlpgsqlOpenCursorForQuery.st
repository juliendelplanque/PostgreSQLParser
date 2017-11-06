tests-plpgsql
testPlpgsqlOpenCursorForQuery
	self
		parse: 'OPEN curs1 FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlOpenCursorForQuery;
		parse: 'OPEN curs1 NO SCROLL FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlOpenCursorForQuery;
		parse: 'OPEN curs1 SCROLL FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlOpenCursorForQuery