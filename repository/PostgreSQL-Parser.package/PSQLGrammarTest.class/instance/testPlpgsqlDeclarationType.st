tests-plpgsql
testPlpgsqlDeclarationType
	self
		parse: 'integer' rule: #plpgsqlDeclarationType;
		parse: 'varchar' rule: #plpgsqlDeclarationType;
		parse: 'varchar(16)' rule: #plpgsqlDeclarationType