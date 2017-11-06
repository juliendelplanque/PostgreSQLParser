tests-plpgsql
testPlpgsqlCursorDelete
	self
		parse: 'DELETE FROM table WHERE CURRENT OF cursor' rule: #plpgsqlCursorDelete