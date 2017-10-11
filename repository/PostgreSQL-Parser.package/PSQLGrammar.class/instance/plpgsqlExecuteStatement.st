plpgsql
plpgsqlExecuteStatement
	"EXECUTE command-string [ INTO [STRICT] target ] [ USING expression [, ... ] ]"
	^ kw execute trim , expression trim ,
	(kw into trim , kw strict trim optional , identifier) trim optional ,
	(kw using trim, (expression plus separatedBy: comma trim))