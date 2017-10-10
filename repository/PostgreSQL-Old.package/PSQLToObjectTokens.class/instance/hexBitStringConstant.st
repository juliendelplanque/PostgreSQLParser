accessing
hexBitStringConstant
	^ super hexBitStringConstant ==> [ :items |
		PSQLHexBitStringConstant new
			contents: (String newFrom: items allButFirst allButLast flattened);
			yourself ]