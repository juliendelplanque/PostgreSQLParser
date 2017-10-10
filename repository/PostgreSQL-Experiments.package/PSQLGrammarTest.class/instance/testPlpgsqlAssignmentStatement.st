tests-plpgsql
testPlpgsqlAssignmentStatement
	self
		parse: 'tax := subtotal * 0.06' rule: #plpgsqlAssignmentStatement;
		parse: 'my_record.user_id := 20' rule: #plpgsqlAssignmentStatement;
		parse: 'my_record.user_id = 20' rule: #plpgsqlAssignmentStatement