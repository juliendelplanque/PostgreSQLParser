accessing
simpleStringConstant
	^ super simpleStringConstant ==> [ :items |
		PSQLSimpleStringConstant new
			contents: (String newFrom: items allButFirst allButLast flattened);
			yourself ]