plpgsql
plpgsqlRaiseStatement2
	"RAISE [ level ] condition_name [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , identifier trim , plpgsqlRaiseUsingOptions optional