plpgsql
plpgsqlExitStatement
	"EXIT [ label ] [ WHEN boolean-expression ]"
	^ kw exit trim , plpgsqlLabel trim optional , (kw when trim , expression) trim optional