tests-accessing
testDollarQuotedStringConstantOpenTag
	self
		fail: '$ hello$' rule: #dollarQuotedStringConstantOpenTag;
		parse: '$hello$' rule: #dollarQuotedStringConstantOpenTag