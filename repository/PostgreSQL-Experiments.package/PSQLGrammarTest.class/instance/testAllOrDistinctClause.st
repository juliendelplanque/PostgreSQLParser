tests
testAllOrDistinctClause
	self
		parse: 'ALL' rule: #allOrDistinctClause;
		parse: 'DISTINCT' rule: #allOrDistinctClause;
		parse: 'DISTINCT ON (id)' rule: #allOrDistinctClause;
		parse: 'DISTINCT ON (id , name,company)' rule: #allOrDistinctClause