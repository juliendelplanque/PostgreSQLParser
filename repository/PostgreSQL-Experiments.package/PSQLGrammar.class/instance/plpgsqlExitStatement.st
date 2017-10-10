plpgsql
plpgsqlExitStatement
	"EXIT [ label ] [ WHEN boolean-expression ]"
	^ exit trim , plpgsqlLabel trim optional , (when trim , expression) trim optional