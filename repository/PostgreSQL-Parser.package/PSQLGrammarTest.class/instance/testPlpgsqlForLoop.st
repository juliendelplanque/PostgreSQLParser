tests-plpgsql
testPlpgsqlForLoop
	self
		parse: 'FOR i IN 1 .. 10 LOOP
    NULL;
END LOOP' rule: #plpgsqlForLoop;
		parse: 'FOR i IN REVERSE 10 .. 1 LOOP
    NULL;
END LOOP' rule: #plpgsqlForLoop;
		parse: 'FOR i IN REVERSE 10 .. 1 BY 2 LOOP
    NULL;
END LOOP' rule: #plpgsqlForLoop;
		parse: '<<label>>
FOR i IN REVERSE 10 .. 1 BY 2 LOOP
    NULL;
END LOOP label' rule: #plpgsqlForLoop