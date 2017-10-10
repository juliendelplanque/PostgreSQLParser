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
	^ if trim , expression , then trim ,
		plpgsqlStatements ,
	((elsif/(else,if)) trim , expression , then trim ,
			plpgsqlStatements) star ,
	else trim ,
		plpgsqlStatements ,
	endKeyword trim , if trim