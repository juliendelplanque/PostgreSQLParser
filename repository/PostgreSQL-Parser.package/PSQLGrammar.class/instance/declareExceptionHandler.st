as yet unclassified
declareExceptionHandler
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
	(kw declare trim , plpgsqlDeclarations trim) optional ,
	kw begin trim ,
		plpgsqlStatements ,
	kw exception trim ,
		(kw when trim , expression , kw then trim , plpgsqlStatements) plus ,
	kw endKeyword trim