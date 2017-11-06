tests-plpgsql
testPlpgsqlCursorUpdate
	self
		parse: 'UPDATE foo SET dataval = myval WHERE CURRENT OF curs1' rule: #plpgsqlCursorUpdate