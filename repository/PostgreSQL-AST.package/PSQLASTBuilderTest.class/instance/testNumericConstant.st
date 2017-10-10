tests-accessing
testNumericConstant
	| node |
	node := builder numericConstant parse: '1.21'.
	
	self
		assert: node class equals: PSQLASTNumericConstant;
		assert: node content equals: '1.21'