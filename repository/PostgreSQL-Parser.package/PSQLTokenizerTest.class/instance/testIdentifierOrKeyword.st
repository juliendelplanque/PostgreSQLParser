tests
testIdentifierOrKeyword
	self
		parse: 'select' rule: #identifierOrKeyword;
		parse: 'SELECT' rule: #identifierOrKeyword;
		parse: '_hello' rule: #identifierOrKeyword;
		parse: 'he$llo$' rule: #identifierOrKeyword;
		parse: '"quoted_identifier"' rule: #identifierOrKeyword;
		parse: 'U&"d\0061t\+000061"' rule: #identifierOrKeyword;
		parse: 'U&"\0441\043B\043E\043D"' rule: #identifierOrKeyword;
		parse: 'U&"d!0061t!+000061"' rule: #identifierOrKeyword