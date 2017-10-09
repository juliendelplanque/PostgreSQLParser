plpgsql
plpgsqlExecuteStatement
	"EXECUTE command-string [ INTO [STRICT] target ] [ USING expression [, ... ] ]"
	^ execute trim , expression trim ,
	(into trim , strict trim optional , identifier) trim optional ,
	(using trim, (expression plus separatedBy: comma trim))