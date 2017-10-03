accessing
positionalParameter
	^ super positionalParameter ==> [ :items |
		PSQLPositionalParameter new
			contents: (String newFrom: items flattened);
			yourself ]