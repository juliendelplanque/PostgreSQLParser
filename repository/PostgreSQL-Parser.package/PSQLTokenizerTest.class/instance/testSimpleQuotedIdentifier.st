tests
testSimpleQuotedIdentifier
	self
		parse: '"select"' rule: #simpleQuotedIdentifier;
		parse: '"SELECT"' rule: #simpleQuotedIdentifier;
		parse: '"_hello"' rule: #simpleQuotedIdentifier;
		parse: '"he$llo$"' rule: #simpleQuotedIdentifier