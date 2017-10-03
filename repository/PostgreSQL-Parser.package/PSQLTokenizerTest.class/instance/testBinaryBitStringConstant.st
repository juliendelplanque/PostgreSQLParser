tests
testBinaryBitStringConstant
	self
		parse: 'b''''' rule: #binaryBitStringConstant;
		parse: 'b''0101''' rule: #binaryBitStringConstant	;
		parse: 'B''''' rule: #binaryBitStringConstant;
		parse: 'B''0101''' rule: #binaryBitStringConstant	