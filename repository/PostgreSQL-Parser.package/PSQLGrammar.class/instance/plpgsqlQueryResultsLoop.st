plpgsql
plpgsqlQueryResultsLoop
	"[ <<label>> ]
	FOR target IN query LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	kw for trim , identifier trim , kw in trim , plpgsqlQuery , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim ,
	plpgsqlEndLabel trim optional