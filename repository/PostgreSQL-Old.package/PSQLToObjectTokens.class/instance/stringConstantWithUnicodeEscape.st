accessing
stringConstantWithUnicodeEscape
	^ super stringConstantWithUnicodeEscape ==> [ :items |
		PSQLStringConstantWithUnicodeEscape new
			contents: (String newFrom: items allButFirst allButLast flattened);
			yourself ]