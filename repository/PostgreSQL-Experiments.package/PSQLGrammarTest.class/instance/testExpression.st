tests-accessing
testExpression
	self
		parse: 'fct()' rule: #expression;
		parse: '++1' rule: #expression;
		parse: '1+1' rule: #expression;
		parse: '1++' rule: #expression;
		parse: '(fct(fct1(variable[1:$2],2),fct2(42)))' rule: #expression;
		parse: '"initiative"."issue_id" = "interest"."issue_id"' rule: #expression