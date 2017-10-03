tests-select command
testFromItems3
	self
		parse: 'queryName' rule: #fromItems3;
		parse: 'queryName as aliasName' rule: #fromItems3;
		parse: 'queryName AS aliasName (c1,C2, c3   )' rule: #fromItems3