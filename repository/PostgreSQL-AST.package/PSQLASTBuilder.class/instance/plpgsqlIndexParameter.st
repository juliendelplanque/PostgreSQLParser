accessing
plpgsqlIndexParameter
	^ super plpgsqlIndexParameter ==> [ :tokens | 
		PSQLASTIdentifier new
			identifier: '$',(String newFrom: tokens second);
			yourself ]