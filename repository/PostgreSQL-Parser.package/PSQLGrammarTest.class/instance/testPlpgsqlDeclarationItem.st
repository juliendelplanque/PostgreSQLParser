tests-plpgsql
testPlpgsqlDeclarationItem
	self
		parse: 'user_id integer' rule: #plpgsqlDeclarationItem;
		parse: 'quantity numeric(5)' rule: #plpgsqlDeclarationItem;
		parse: 'url varchar' rule: #plpgsqlDeclarationItem;
		parse: 'myrow tablename%ROWTYPE' rule: #plpgsqlDeclarationItem;
		parse: 'myfield tablename.columnname%TYPE' rule: #plpgsqlDeclarationItem;
		parse: 'arow RECORD' rule: #plpgsqlDeclarationItem;
		parse: 'curs1 refcursor' rule: #plpgsqlDeclarationItem;
		parse: 'curs2 SCROLL CURSOR FOR SELECT * FROM tenk1' rule: #plpgsqlDeclarationItem;
		parse: 'curs3 CURSOR (key integer) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlDeclarationItem;
		parse: 'curs3 NO SCROLL CURSOR (key integer, key2 char , key3 varchar) FOR SELECT * FROM tenk1 WHERE unique1 = key' rule: #plpgsqlDeclarationItem