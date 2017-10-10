tests-plpgsql
testPlpgsqlWhileLoop
	self
		parse: 'WHILE amount_owed < 42 LOOP
    amount_owed := amount_owed + 1;
END LOOP' rule: #plpgsqlWhileLoop;
		parse: 'WHILE amount_owed < 42 LOOP
    NULL;
END LOOP' rule: #plpgsqlWhileLoop;
		parse: '<<label>>
WHILE amount_owed < 42 LOOP
    NULL;
END LOOP label' rule: #plpgsqlWhileLoop