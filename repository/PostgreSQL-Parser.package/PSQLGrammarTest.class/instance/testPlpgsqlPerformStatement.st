tests-plpgsql
testPlpgsqlPerformStatement
	self
		parse: 'PERFORM "require_transaction_isolation"()' rule: #plpgsqlPerformStatement