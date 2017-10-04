tests-select command
testFromItems6
	self
		parse: 'JOIN "interest" ON "initiative"."issue_id" = "interest"."issue_id"' rule: #fromItems6;
		parse: 'LEFT JOIN "membership"' rule: #fromItems6