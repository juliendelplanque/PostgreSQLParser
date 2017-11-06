tests-plpgsql
testPlpgsqlCursorForLoop
	self
		parse: 'FOR record_var in curs1 (key1 := 1, key2 := 42) LOOP
	var := record;
END LOOP' rule: #plpgsqlCursorForLoop