accessing
operator
	^ super operator ==> [ :items |
		PSQLOperator new
			contents: (String newFrom: items flattened);
			yourself ]