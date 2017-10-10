tests-accessing
testLimitClause
	self
		parse: 'LIMIT 42' rule: #limitClause;
		parse: 'LIMIT ALL' rule: #limitClause