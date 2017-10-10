tests-select command
testGroupByClause
	self
		parse: 'GROUP BY table."column_name"' rule: #groupByClause;
		parse: 'GROUP BY table."column_name", table."column_name2",table.column_name3' rule: #groupByClause