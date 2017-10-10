tests-plpgsql
testPlpgsqlIfThen
	self
		parse: 'IF v_user_id <> 0 THEN
    v_user_id := 42;
END IF' rule: #plpgsqlIfThen;
		parse: 'IF "policy_row"."tie_breaking" != ''simple''::"tie_breaking" THEN
	NULL;
END IF' rule: #plpgsqlIfThen