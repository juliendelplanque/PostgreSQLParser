tests-accessing
testFetchClause
	self
		parse: 'FETCH FIRST ROW ONLY' rule: #fetchClause;
		parse: 'FETCH FIRST 42 ROWS ONLY' rule: #fetchClause;
		parse: 'FETCH NEXT ROW ONLY' rule: #fetchClause;
		parse: 'FETCH NEXT 42 ROWS ONLY' rule: #fetchClause