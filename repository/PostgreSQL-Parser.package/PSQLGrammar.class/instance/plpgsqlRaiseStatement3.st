plpgsql
plpgsqlRaiseStatement3
	"RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ]"
	^ kw raise trim , plpgsqlRaiseLevel trim optional , 'SQLSTATE' asParser trim , simpleStringConstant trim ,
	plpgsqlRaiseUsingOptions optional