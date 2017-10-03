tests
testNumericConstant
	self
		parse: '42' rule: #numericConstant;
		parse: '3.5' rule: #numericConstant;
		parse: '4.' rule: #numericConstant;
		parse: '.001' rule: #numericConstant;
		parse: '5e2' rule: #numericConstant;
		parse: '1.925e-3' rule: #numericConstant