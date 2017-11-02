tests-plpgsql
testPlpgsqlDeclarationType
	self
		parse: 'integer' rule: #plpgsqlDeclarationType;
		parse: 'varchar' rule: #plpgsqlDeclarationType;
		parse: 'varchar(16)' rule: #plpgsqlDeclarationType;
		parse: 'char(5)[][]' rule: #plpgsqlDeclarationType;
		parse: 'varying char(16)[][]' rule: #plpgsqlDeclarationType