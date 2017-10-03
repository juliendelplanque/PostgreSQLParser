tests-select command
testFromItems6
	self
		parse: '"initiative" JOIN "interest" ON "initiative"."issue_id" = "interest"."issue_id"' rule: #fromItems6;
		parse: '"area_delegation" LEFT JOIN "membership"' rule: #fromItems6