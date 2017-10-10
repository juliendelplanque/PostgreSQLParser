plpgsql
plpgsqlArrayLoop
	"[ <<label>> ]
	FOREACH target [ SLICE number ] IN ARRAY expression LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	foreach trim , identifier , (slice trim , numericConstant) trim optional , in trim , array trim , expression , loop trim ,
		plpgsqlStatements ,
	endKeyword trim , loop trim ,
	plpgsqlLabel trim optional