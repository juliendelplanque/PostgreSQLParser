tests-plpgsql
testPlpgsqlLoopLoop
	self
		parse: 'LOOP
    IF count > 0 THEN
        EXIT;
    END IF;
END LOOP' rule: #plpgsqlLoopLoop;
		parse: 'LOOP
    EXIT WHEN count > 0;
END LOOP' rule: #plpgsqlLoopLoop