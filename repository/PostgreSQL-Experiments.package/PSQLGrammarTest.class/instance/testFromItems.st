tests
testFromItems
	self
		parse: 'ONLY table * AS alias (c1, c2,C3)' rule: #fromItems;
		parse: 'table * AS alias (c1, c2,C3)' rule: #fromItems;
		parse: 'ONLY table AS alias (c1, c2,C3)' rule: #fromItems;
		parse: 'ONLY table *' rule: #fromItems;
		parse: '(SELECT * FROM table) AS alias' rule: #fromItems;
		parse: '(SELECT * FROM table) AS alias (c1,c2,C3)' rule: #fromItems;
		parse: 'queryName' rule: #fromItems;
		parse: 'queryName as aliasName' rule: #fromItems;
		parse: 'queryName AS aliasName (c1,C2, c3   )' rule: #fromItems;
		parse: 'function(1, "a") AS aliasName (c1, C2, "C3")' rule: #fromItems;
		parse: 'function(1, "a") aliasName (c1, C2, "C3")' rule: #fromItems;
		parse: 'function(1, "a") AS aliasName' rule: #fromItems;
		parse: 'function(1, "a") aliasName' rule: #fromItems;
		parse: '"initiative" JOIN "interest" ON "initiative"."issue_id" = "interest"."issue_id"' rule: #fromItems;
		parse: '"area_delegation" LEFT JOIN "membership"' rule: #fromItems