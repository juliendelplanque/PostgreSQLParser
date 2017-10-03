tests-accessing
testUnaryPostfixOperator
	self
		parse: '42++' rule: #expression;
		parse: 'id--' rule: #expression;
		parse: '1++--' rule: #expression;
		parse: '$1++' rule: #expression