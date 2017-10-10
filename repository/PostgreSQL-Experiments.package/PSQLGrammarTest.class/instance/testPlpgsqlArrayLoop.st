tests-plpgsql
testPlpgsqlArrayLoop
	self
		parse: 'FOREACH x IN ARRAY $1
  LOOP
    s := s + x;
  END LOOP' rule: #plpgsqlArrayLoop