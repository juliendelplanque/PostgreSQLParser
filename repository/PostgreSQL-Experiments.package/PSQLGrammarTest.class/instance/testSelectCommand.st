tests-select command
testSelectCommand
	self
		parse: 'SELECT 1 + 1' rule: #selectCommand;
		parse: 'SELECT DISTINCT ON (id, name) *' rule: #selectCommand;
		parse: 'SELECT DISTINCT ON (id, name) result, other, onemore' rule: #selectCommand;
		parse: 'SELECT ALL id, name, test AS result, other, onemore' rule: #selectCommand;
		parse: 'SELECT count(id) FROM table1' rule: #selectCommand