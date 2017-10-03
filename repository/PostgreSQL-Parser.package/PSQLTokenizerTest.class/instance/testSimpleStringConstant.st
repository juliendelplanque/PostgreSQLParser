tests
testSimpleStringConstant
	self
		parse: '''Hello you!''' rule: #simpleStringConstant;
		parse: '''Hello \''mister\''!''' rule: #simpleStringConstant