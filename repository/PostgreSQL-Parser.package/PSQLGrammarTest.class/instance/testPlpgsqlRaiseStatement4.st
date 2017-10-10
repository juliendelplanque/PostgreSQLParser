tests-plpgsql
testPlpgsqlRaiseStatement4
	self
		parse: 'RAISE INFO USING ERRCODE = ''23505''' rule: #plpgsqlRaiseStatement4;
		parse: 'RAISE INFO USING ERRCODE = ''23505'' , OTHER = ''test''' rule: #plpgsqlRaiseStatement4