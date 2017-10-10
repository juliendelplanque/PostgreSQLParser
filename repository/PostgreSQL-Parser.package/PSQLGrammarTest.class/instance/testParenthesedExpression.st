tests-accessing
testParenthesedExpression
	self
		parse: '(1+$1)' rule: #expression;
		parse: '(fct())' rule: #expression;
		parse: '(fct(table.column)[1])' rule: #expression;
		parse: '(++fct(table,42))' rule: #expression;
		parse: '(fct(fct2(table),42))' rule: #expression