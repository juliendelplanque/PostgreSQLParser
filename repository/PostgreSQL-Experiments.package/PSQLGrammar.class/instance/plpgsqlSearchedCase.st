plpgsql
plpgsqlSearchedCase
	"CASE
    	WHEN boolean-expression THEN
      		statements
  		[ WHEN boolean-expression THEN
      		statements
    		... ]
  		[ ELSE
      		statements ]
	END CASE"
	^ case trim ,
		(when trim , expression , then trim ,
			plpgsqlStatements) plus ,
		(else trim , plpgsqlStatements) optional ,
		endKeyword trim , case trim