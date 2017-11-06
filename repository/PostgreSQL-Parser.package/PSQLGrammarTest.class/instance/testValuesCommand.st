tests-values command
testValuesCommand
	self
		parse: 'VALUES (1, ''one''), (2, ''two''), (3, ''three'')' rule: #valuesCommand;
		parse: 'VALUES (1, DEFAULT)' rule: #valuesCommand