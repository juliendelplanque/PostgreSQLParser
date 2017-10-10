tests-plpgsql
testPlpgsqlExceptionHandler
	self
		parse: 'BEGIN
    x := x + 1;
    y := x / 0;
EXCEPTION
    WHEN division_by_zero THEN
        RETURN x;
END' rule: #plpgsqlExceptionHandler