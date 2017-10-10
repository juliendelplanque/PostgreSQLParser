tests-plpgsql
testPlpgsqlDeclarationItem
	self
		parse: 'user_id integer' rule: #plpgsqlDeclarationItem;
		parse: 'quantity numeric(5)' rule: #plpgsqlDeclarationItem;
		parse: 'url varchar' rule: #plpgsqlDeclarationItem;
		parse: 'myrow tablename%ROWTYPE' rule: #plpgsqlDeclarationItem;
		parse: 'myfield tablename.columnname%TYPE' rule: #plpgsqlDeclarationItem;
		parse: 'arow RECORD' rule: #plpgsqlDeclarationItem