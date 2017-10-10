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
	^ case trim , expression ,
		(when trim , (expression plus separatedBy: comma trim) , then trim ,
			plpgsqlStatements) plus ,
		(else trim ,
			plpgsqlStatements) optional ,
		endKeyword trim , case trim