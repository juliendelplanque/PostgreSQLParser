tests-expression
testFunctionCallParserWith
	| node |
	node := builder expression parse: 'fct(1, id, arg := ''argument'', 41 + 1)'.
	self
		assert: node class equals: PSQLFunctionCall;
		assert: node functionIdentifier class equals: PSQLASTIdentifier;
		assert: node functionIdentifier identifier equals: 'fct';
		assert: node argumentsList size equals: 3;
		assert: node argumentsList first class equals: PSQLASTNumericConstant;
		assert: node argumentsList second class equals: PSQLASTIdentifier;
		assert: node argumentsList third class equals: PSQLASTBinaryOperator;
		assert: node argumentsDictionary size equals: 1;
		assert: node argumentsDictionary associations first head class equals: PSQLASTIdentifier;
		assert: node argumentsDictionary associations first tail class equals: PSQLASTStringConstant