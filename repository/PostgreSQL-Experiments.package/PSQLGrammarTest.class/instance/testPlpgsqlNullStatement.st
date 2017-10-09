tests-plpgsql
testPlpgsqlNullStatement
	self
		parse: 'NULL' rule: #plpgsqlNullStatement;
		parse: '    
' rule: #plpgsqlNullStatement