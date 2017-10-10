plpgsql
plpgsqlRaiseStatement
	"RAISE [ level ] 'format' [, expression [, ... ]] [ USING option = expression [, ... ] ]
	RAISE [ level ] condition_name [ USING option = expression [, ... ] ]
	RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ]
	RAISE [ level ] USING option = expression [, ... ]
	RAISE "
	^ plpgsqlRaiseStatement1 / plpgsqlRaiseStatement2 /plpgsqlRaiseStatement3 / plpgsqlRaiseStatement4 / plpgsqlRaiseStatement5