plpgsql
plpgsqlLoopLoop
	"[ <<label>> ]
	LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	loop trim , plpgsqlStatements ,
	endKeyword trim , loop trim ,
	plpgsqlEndLabel trim optional