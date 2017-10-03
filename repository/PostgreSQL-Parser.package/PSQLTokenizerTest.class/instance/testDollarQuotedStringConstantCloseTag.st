tests-accessing
testDollarQuotedStringConstantCloseTag
	self
		parse: '$ hello$' rule: #dollarQuotedStringConstantCloseTag;
		fail: '$hello$' rule: #dollarQuotedStringConstantCloseTag