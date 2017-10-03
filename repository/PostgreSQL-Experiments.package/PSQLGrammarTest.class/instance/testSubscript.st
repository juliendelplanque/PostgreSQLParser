tests-accessing
testSubscript
	self
		parse: 'identifier[1]' rule: #expression;
		parse: 'identifier[4:59]' rule: #expression;
		parse: 'mytable.arraycolumn[4]' rule: #expression;
		parse: 'mytable.two_d_column[17][34]' rule: #expression;
		parse: '$1[10:42]' rule: #expression;
		parse: '(arrayfunction(a,b))[42]' rule: #expression