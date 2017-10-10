tests-accessing
testBinaryOperator
	self
		parse: '2*2' rule: #expression;
		parse: '2*$3*4' rule: #expression;
		parse: '2*(3+value)' rule: #expression;
		parse: '(3+value)/2' rule: #expression