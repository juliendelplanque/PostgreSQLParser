tests
testQuotedIdentifier
	self
		parse: '"select"' rule: #quotedIdentifier;
		parse: '"SELECT"' rule: #quotedIdentifier;
		parse: '"_hello"' rule: #quotedIdentifier;
		parse: '"he$llo$"' rule: #quotedIdentifier;
		parse: 'U&"d\0061t\+000061"' rule: #quotedIdentifier;
		parse: 'U&"\0441\043B\043E\043D"' rule: #quotedIdentifier;
		parse: 'U&"d!0061t!+000061"' rule: #quotedIdentifier