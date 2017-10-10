tests-plpgsql
testPlpgsqlRaiseStatement1
	self
		parse: 'RAISE EXCEPTION ''Nonexistent ID --> %'', user_id
      USING HINT = ''Please check your user ID''' rule: #plpgsqlRaiseStatement1