tests-keywords
testJoinType
	self
		parse: 'INNER JOIN' rule: #joinType;
		parse: 'LEFT OUTER JOIN' rule: #joinType;
		parse: 'LEFT JOIN' rule: #joinType;
		parse: 'RIGHT OUTER JOIN' rule: #joinType;
		parse: 'RIGHT JOIN' rule: #joinType;
		parse: 'FULL OUTER JOIN' rule: #joinType;
		parse: 'FULL JOIN' rule: #joinType;
		parse: 'CROSS JOIN' rule: #joinType;
		parse: 'JOIN' rule: #joinType