accessing
plpgsqlStatements
	^ super plpgsqlStatements ==> [ :tokens |
		OrderedCollection new
			add: tokens first;
			addAll: (tokens second collect: #second);
			yourself ]