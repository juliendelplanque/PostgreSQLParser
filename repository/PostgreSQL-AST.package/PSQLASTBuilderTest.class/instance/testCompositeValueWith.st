tests-expression
testCompositeValueWith
	| node |
	node := builder expression parse: '(1, id*3, table.attribute)'.
	self
		assert: node class equals: PSQLCompositeValue;
		assert: node items size equals: 3;
		assert: node items first class equals: PSQLASTNumericConstant;
		assert: node items second class equals: PSQLASTBinaryOperator;
		assert: node items third class equals: PSQLASTAttributeAccess.
		
	node := builder expression parse: '((-1::INT8) << 63, 0)::"link_strength"'.
	self
		assert: node class equals: PSQLASTBinaryOperator;
		assert: node left class equals: PSQLCompositeValue;
		assert: node left items size equals: 2;
		assert: node operator equals: '::';
		assert: node right class equals: PSQLASTIdentifier.