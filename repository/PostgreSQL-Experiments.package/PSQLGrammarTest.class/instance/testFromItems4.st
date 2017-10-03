tests-select command
testFromItems4
	self
		parse: 'function(1, "a") AS aliasName (c1, C2, "C3")' rule: #fromItems4;
		parse: 'function(1, "a") aliasName (c1, C2, "C3")' rule: #fromItems4;
		parse: 'function(1, "a") AS aliasName' rule: #fromItems4;
		parse: 'function(1, "a") aliasName' rule: #fromItems4