tests-select command
testWhereClause
	self
		parse: 'WHERE 1 + 1 = 2';
		parse: 'WHERE table.id = 42';
		parse: 'WHERE fct(table)  = ''test'''