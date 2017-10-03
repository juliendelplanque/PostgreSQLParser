accessing
oneLineComment
	^ super oneLineComment ==> [ :items | 
		PSQLOneLineComment new
			contents: (String newFrom: items allButFirst flattened);
			yourself ]