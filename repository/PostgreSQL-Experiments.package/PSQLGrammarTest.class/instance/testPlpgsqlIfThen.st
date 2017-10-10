tests-plpgsql
testPlpgsqlIfThen
	self
		parse: 'IF v_user_id <> 0 THEN
    v_user_id := 42;
END IF' rule: #plpgsqlIfThen