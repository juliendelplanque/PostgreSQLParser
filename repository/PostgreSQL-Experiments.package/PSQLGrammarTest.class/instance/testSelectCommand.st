tests-select command
testSelectCommand
	self
		parse: 'SELECT 1 + 1' rule: #selectCommand;
		parse: 'SELECT DISTINCT ON (id, name) *';
		parse: 'SELECT DISTINCT ON (id, name) * AS result, other, onemore';
		parse: 'SELECT ALL id, name, test AS result, other, onemore';
		parse: 'SELECT count(id) FROM table1'