tests-plpgsql
testPlpgsqlSimpleCase
	self
		parse: 'CASE x
    WHEN 1, 2 THEN
        msg := ''one or two'';
    ELSE
        msg := ''other value than one or two'';
END CASE' rule: #plpgsqlSimpleCase;
		parse: 'CASE x
    WHEN 1, 2 THEN
        msg := ''one or two'';
	WHEN 3, 4 THEN
        msg := ''three or four'';
END CASE' rule: #plpgsqlSimpleCase