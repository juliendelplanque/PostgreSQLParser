tests-accessing
testSimpleStringConstant
	| node |
	node := builder simpleStringConstant parse: '''test'''.
	
	self
		assert: node class equals: PSQLASTStringConstant;
		assert: node content equals: 'test'