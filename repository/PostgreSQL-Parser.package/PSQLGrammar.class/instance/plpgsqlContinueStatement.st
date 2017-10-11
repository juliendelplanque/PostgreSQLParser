plpgsql
plpgsqlContinueStatement
	"CONTINUE [ label ] [ WHEN boolean-expression ]"
	^ kw continue trim , plpgsqlLabel trim optional , (kw when trim , expression) trim optional