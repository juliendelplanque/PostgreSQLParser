tests-select command
testForClause
	self
		parse: 'FOR UPDATE' rule: #forClause;
		parse: 'FOR SHARE' rule: #forClause;
		parse: 'FOR UPDATE OF table1,table2 , table3' rule: #forClause;
		parse: 'FOR UPDATE NOWAIT' rule: #forClause;
		parse: 'FOR UPDATE OF table1,table2 , table3 NOWAIT' rule: #forClause;
		parse: 'FOR SHARE OF table1,table2 , table3' rule: #forClause;
		parse: 'FOR SHARE NOWAIT' rule: #forClause;
		parse: 'FOR SHARE OF table1,table2 , table3 NOWAIT' rule: #forClause