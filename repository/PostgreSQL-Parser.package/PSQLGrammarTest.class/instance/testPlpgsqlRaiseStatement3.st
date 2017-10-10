tests-plpgsql
testPlpgsqlRaiseStatement3
	self
		parse: 'RAISE INFO SQLSTATE ''22012''' rule: #plpgsqlRaiseStatement3;
		parse: 'RAISE INFO SQLSTATE ''22012'' USING ERRCODE = ''err''' rule: #plpgsqlRaiseStatement3