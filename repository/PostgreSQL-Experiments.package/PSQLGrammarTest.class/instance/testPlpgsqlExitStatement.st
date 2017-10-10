tests-plpgsql
testPlpgsqlExitStatement
	self
		parse: 'EXIT' rule: #plpgsqlExitStatement;
		parse: 'EXIT WHEN count > 0' rule: #plpgsqlExitStatement;
		parse: 'EXIT ablock' rule: #plpgsqlExitStatement;
		parse: 'EXIT ablock WHEN count > 0' rule: #plpgsqlExitStatement