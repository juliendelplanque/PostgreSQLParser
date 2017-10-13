plpgsql
plpgsqlSimpleCase
	"CASE
    	WHEN boolean-expression THEN
      		statements
  		[ WHEN boolean-expression THEN
      		statements
    		... ]
  		[ ELSE
      		statements ]
	END CASE"
	^ kw case trim ,
		(kw when trim , expression , kw then trim ,
			plpgsqlStatements) plus ,
		(kw else trim , plpgsqlStatements) optional ,
		kw endKeyword trim , kw case trim