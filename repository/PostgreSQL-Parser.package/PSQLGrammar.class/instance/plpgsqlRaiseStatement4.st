plpgsql
plpgsqlRaiseStatement4
	"RAISE [ level ] USING option = expression [, ... ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional ,
		plpgsqlRaiseUsingOptions