tests
testHexBitStringConstant
	self
		parse: 'x''''' rule: #hexBitStringConstant;
		parse: 'x''1F''' rule: #hexBitStringConstant;
		parse: 'X''''' rule: #hexBitStringConstant;
		parse: 'X''1F''' rule: #hexBitStringConstant	