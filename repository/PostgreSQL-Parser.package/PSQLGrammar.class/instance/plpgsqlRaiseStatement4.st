plpgsql
plpgsqlRaiseStatement4
	"RAISE [ level ] USING option = expression [, ... ]"
	^ raise trim , plpgsqlRaiseLevel trim optional ,
		plpgsqlRaiseUsingOptions