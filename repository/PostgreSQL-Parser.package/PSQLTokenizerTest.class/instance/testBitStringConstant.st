tests
testBitStringConstant
	self
		parse: 'b''''' rule: #bitStringConstant;
		parse: 'b''0101''' rule: #bitStringConstant	;
		parse: 'B''''' rule: #bitStringConstant;
		parse: 'B''0101''' rule: #bitStringConstant	;
		parse: 'x''''' rule: #bitStringConstant;
		parse: 'x''1F''' rule: #bitStringConstant;
		parse: 'X''''' rule: #bitStringConstant;
		parse: 'X''1F''' rule: #bitStringConstant