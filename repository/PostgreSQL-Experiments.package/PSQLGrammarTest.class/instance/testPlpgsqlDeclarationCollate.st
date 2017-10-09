tests-plpgsql
testPlpgsqlDeclarationCollate
	self
		parse: 'COLLATE "en_US"' rule: #plpgsqlDeclarationCollate;
		parse: 'COLLATE "C"' rule: #plpgsqlDeclarationCollate