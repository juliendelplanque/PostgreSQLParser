plpgsql
plpgsqlContinueStatement
	"CONTINUE [ label ] [ WHEN boolean-expression ]"
	^ continue trim , plpgsqlLabel trim optional , (when trim , expression) trim optional