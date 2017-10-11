plpgsql
plpgsqlArrayLoop
	"[ <<label>> ]
	FOREACH target [ SLICE number ] IN ARRAY expression LOOP
    	statements
	END LOOP [ label ]"
	^ plpgsqlBeginLabel trim optional ,
	kw foreach trim , identifier , (kw slice trim , numericConstant) trim optional , kw in trim , kw array trim , expression , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim ,
	plpgsqlLabel trim optional