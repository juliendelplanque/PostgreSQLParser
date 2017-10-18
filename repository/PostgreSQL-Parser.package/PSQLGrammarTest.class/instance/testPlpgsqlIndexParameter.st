tests-plpgsql
testPlpgsqlIndexParameter
	self
		parse: '$1' rule: #plpgsqlIndexParameter;
		parse: '$42' rule: #plpgsqlIndexParameter