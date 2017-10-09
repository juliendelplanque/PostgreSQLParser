tests-select command
testFromItems1
	self
		"parse: 'ONLY table * AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'table * AS alias (c1, c2,C3)' rule: #fromItems1;"
		parse: 'ONLY table AS alias (c1, c2,C3)' rule: #fromItems1;
		parse: 'ONLY table *' rule: #fromItems1