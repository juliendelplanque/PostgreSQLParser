plpgsql
plpgsqlIfThenElsif
	"IF boolean-expression THEN
    	statements
	[ ELSIF boolean-expression THEN
   	 	statements
	[ ELSIF boolean-expression THEN
    	statements
    ...]]
	[ ELSE
    	statements ]
	END IF"
	^ kw if trim , expression , kw then trim ,
		plpgsqlStatements ,
	((kw elsif/(kw else,kw if)) trim , expression , kw then trim ,
			plpgsqlStatements) star ,
	(kw else trim ,
		plpgsqlStatements) optional ,
	kw endKeyword trim , kw if trim