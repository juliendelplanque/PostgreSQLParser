tests-select command
testFromClause
	"A smoke test with multiple FROM clauses extracted from existing open-source schemas."
	self
		parse: 'FROM "initiative"' rule: #fromClause;
		parse: 'FROM "area_delegation" LEFT JOIN "membership"' rule: #fromClause;
		parse: 'FROM affectation,support,personne' rule: #fromClause