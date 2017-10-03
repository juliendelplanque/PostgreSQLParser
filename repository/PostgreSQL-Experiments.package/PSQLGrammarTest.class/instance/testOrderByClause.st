tests-accessing
testOrderByClause
	self
		parse: 'ORDER BY a + b, c' rule: #orderByClause;
		parse: 'ORDER BY sum' rule: #orderByClause;
		parse: 'ORDER BY 1 ASC NULLS LAST' rule: #orderByClause