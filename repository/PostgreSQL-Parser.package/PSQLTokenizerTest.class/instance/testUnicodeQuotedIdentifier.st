tests
testUnicodeQuotedIdentifier
	self
		parse: 'U&"d\0061t\+000061"' rule: #unicodeQuotedIdentifier;
		parse: 'U&"\0441\043B\043E\043D"' rule: #unicodeQuotedIdentifier;
		parse: 'U&"d!0061t!+000061"' rule: #unicodeQuotedIdentifier