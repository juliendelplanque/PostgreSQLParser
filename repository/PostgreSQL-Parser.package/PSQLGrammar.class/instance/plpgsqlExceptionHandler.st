plpgsql
plpgsqlExceptionHandler
	"[ <<label>> ]
	[ DECLARE
    	declarations ]
	BEGIN
    	statements
	EXCEPTION
    	WHEN condition [ OR condition ... ] THEN
        	handler_statements
    	[ WHEN condition [ OR condition ... ] THEN
          handler_statements
      ... ]
	END"
	^ plpgsqlBeginLabel trim optional ,
	(declare trim , plpgsqlDeclarations trim) optional ,
	begin trim ,
		plpgsqlStatements ,
	exception trim ,
		(when trim , expression , then trim , plpgsqlStatements) plus ,
	endKeyword trim