accessing
numericConstant
	^ super numericConstant ==> [ :items |
		PSQLNumericConstant new
			contents: (String newFrom: (items flattened reject: #isNil));
			yourself ]