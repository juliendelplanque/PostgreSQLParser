plpgsql
plpgsqlQueryResultsLoop
	"[ <<label>> ]
	FOR target IN query LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	for trim , identifier trim , in trim , plpgsqlQuery , loop trim ,
		plpgsqlStatements ,
	endKeyword trim , loop trim ,
	plpgsqlEndLabel trim optional