tests-plpgsql
testPlpgsqlAssertStatement
	self
		parse: 'ASSERT 1 + 1 = 2' rule: #plpgsqlAssertStatement;
		parse: 'ASSERT 1 + 1 = 2, ''KO''' rule: #plpgsqlAssertStatement;
		parse: 'ASSERT 1 + 1 = 2, ''Should'' || notBeRaised()' rule: #plpgsqlAssertStatement