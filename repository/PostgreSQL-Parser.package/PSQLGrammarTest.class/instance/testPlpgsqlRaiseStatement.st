tests-plpgsql
testPlpgsqlRaiseStatement
	self
		parse: 'RAISE NOTICE ''Calling cs_create_job(%)'', v_job_id' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE EXCEPTION ''Nonexistent ID --> %'', user_id
      USING HINT = ''Please check your user ID''' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE ''Duplicate user ID: %'', user_id USING ERRCODE = ''unique_violation''' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE ''Duplicate user ID: %'', user_id USING ERRCODE = ''23505''' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE division_by_zero' rule: #plpgsqlRaiseStatement;
		parse: 'RAISE unique_violation USING MESSAGE = ''Duplicate user ID: '' || user_id' rule: #plpgsqlRaiseStatement