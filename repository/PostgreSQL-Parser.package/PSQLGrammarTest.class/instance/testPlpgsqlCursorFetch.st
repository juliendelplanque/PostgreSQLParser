tests-plpgsql
testPlpgsqlCursorFetch
	self
		parse: 'FETCH curs1 INTO rowvar' rule: #plpgsqlCursorFetch;
		parse: 'FETCH curs2 INTO foo, bar, baz' rule: #plpgsqlCursorFetch;
		parse: 'FETCH LAST FROM curs3 INTO x, y' rule: #plpgsqlCursorFetch;
		parse: 'FETCH RELATIVE -2 FROM curs4 INTO x' rule: #plpgsqlCursorFetch