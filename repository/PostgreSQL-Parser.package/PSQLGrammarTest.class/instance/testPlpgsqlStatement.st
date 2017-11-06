tests-plpgsql
testPlpgsqlStatement
	self
		parse: 'v_user_id := 42' rule: #plpgsqlStatement;
		parse: '((-1::INT8) << 63, 0)::"link_strength"' rule: #plpgsqlStatement;
		parse: 'OPEN curs1 FOR EXECUTE format(''SELECT * FROM %I WHERE col1 = $1'',tabname) USING keyvalue' rule: #plpgsqlStatement;
		parse: 'OPEN curs1 FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlStatement;
		parse: 'OPEN curs1 NO SCROLL FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlStatement;
		parse: 'OPEN curs1 SCROLL FOR SELECT * FROM foo WHERE key = mykey' rule: #plpgsqlStatement;
		parse: 'OPEN curs2' rule: #plpgsqlStatement;
		parse: 'OPEN curs3(42)' rule: #plpgsqlStatement;
		parse: 'OPEN curs3(key := 42)' rule: #plpgsqlStatement;
		parse: 'OPEN curs3(key := 42, key2 := ''test'')' rule: #plpgsqlStatement;
		parse: 'OPEN curs1 FOR EXECUTE format(''SELECT * FROM %I WHERE col1 = $1'',tabname) USING keyvalue' rule: #plpgsqlStatement;
		parse: 'FETCH curs1 INTO rowvar' rule: #plpgsqlStatement;
		parse: 'FETCH curs2 INTO foo, bar, baz' rule: #plpgsqlStatement;
		parse: 'FETCH LAST FROM curs3 INTO x, y' rule: #plpgsqlStatement;
		parse: 'FETCH RELATIVE -2 FROM curs4 INTO x' rule: #plpgsqlStatement;
		parse: 'MOVE curs1' rule: #plpgsqlStatement;
		parse: 'MOVE LAST FROM curs3' rule: #plpgsqlStatement;
		parse: 'MOVE RELATIVE -2 FROM curs4' rule: #plpgsqlStatement;
		parse: 'MOVE FORWARD 2 FROM curs4' rule: #plpgsqlStatement;
		parse: 'DELETE FROM table WHERE CURRENT OF cursor' rule: #plpgsqlStatement;
		parse: 'UPDATE foo SET dataval = myval WHERE CURRENT OF curs1' rule: #plpgsqlStatement;
		parse: 'CLOSE curs1' rule: #plpgsqlStatement;
		parse: 'FOR record_var in curs1 (key1 := 1, key2 := 42) LOOP
	var := record;
END LOOP' rule: #plpgsqlStatement