tests-plpgsql
testPlpgsqlCursorDeclaration
	self
		parse: 'curs2 SCROLL CURSOR FOR SELECT * FROM tenk1' rule: #plpgsqlCursorDeclaration;
		parse: 'curs3 CURSOR (key integer) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlCursorDeclaration;
		parse: 'curs3 NO SCROLL CURSOR (key integer, key2 char , key3 varchar) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlCursorDeclaration