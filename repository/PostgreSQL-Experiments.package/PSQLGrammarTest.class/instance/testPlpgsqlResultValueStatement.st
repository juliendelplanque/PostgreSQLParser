tests-plpgsql
testPlpgsqlResultValueStatement
	self
		parse: 'GET DIAGNOSTICS integer_var = ROW_COUNT' rule: #plpgsqlResultValueStatement