plpgsql
plpgsqlLoopLoop
	"[ <<label>> ]
	LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	kw loop trim , plpgsqlStatements ,
	kw endKeyword trim , kw loop trim ,
	plpgsqlEndLabel trim optional