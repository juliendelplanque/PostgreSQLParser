tests-plpgsql
testPlpgsqlRaiseStatement2
	self
		parse: 'RAISE division_by_zero' rule: #plpgsqlRaiseStatement2;
		parse: 'RAISE division_by_zero USING ERRCODE = ''1234''' rule: #plpgsqlRaiseStatement2