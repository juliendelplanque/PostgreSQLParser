accessing
binaryBitStringConstant
	^ super binaryBitStringConstant ==> [ :items |
		PSQLBinaryBitStringConstant new
			contents: (String newFrom: items flattened);
			yourself ]