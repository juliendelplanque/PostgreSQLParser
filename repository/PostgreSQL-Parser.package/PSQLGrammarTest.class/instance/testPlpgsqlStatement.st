tests-plpgsql
testPlpgsqlStatement
	self
		parse: 'v_user_id := 42' rule: #plpgsqlStatement;
		parse: '((-1::INT8) << 63, 0)::"link_strength"' rule: #plpgsqlStatement