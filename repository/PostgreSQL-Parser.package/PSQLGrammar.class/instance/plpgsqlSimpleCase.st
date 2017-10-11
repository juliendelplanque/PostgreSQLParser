plpgsql
plpgsqlSimpleCase
	"CASE search-expression
    	WHEN expression [, expression [ ... ]] THEN
    		statements
  		[ WHEN expression [, expression [ ... ]] THEN
      		statements
   		 ... ]
  		[ ELSE
      		statements ]
	END CASE"
	^ kw case trim , expression ,
		(kw when trim , (expression plus separatedBy: comma trim) , kw then trim ,
			plpgsqlStatements) plus ,
		(kw else trim ,
			plpgsqlStatements) optional ,
		kw endKeyword trim , kw case trim