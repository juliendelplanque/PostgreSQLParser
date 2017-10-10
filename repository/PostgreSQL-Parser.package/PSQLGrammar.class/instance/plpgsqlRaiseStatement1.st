plpgsql
plpgsqlRaiseStatement1
	"RAISE [ level ] 'format' [, expression [, ... ]] [ USING option = expression [, ... ] ]"
	^ raise trim , plpgsqlRaiseLevel trim optional , simpleStringConstant trim , (expression star separatedBy: comma trim) , plpgsqlRaiseUsingOptions optional