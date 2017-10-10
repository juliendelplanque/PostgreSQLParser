tests-select command
testFromClause
	"A smoke test with multiple FROM clauses extracted from existing open-source schemas."
	self
		parse: 'FROM "initiative"' rule: #fromClause;
		parse: 'FROM "area_delegation" LEFT JOIN "membership"' rule: #fromClause;
		parse: 'FROM affectation,support,personne' rule: #fromClause;
		parse: 'FROM (((personne LEFT JOIN these ON ((personne.cle = these.cle_personne))) LEFT JOIN civilite ON ((personne.civilite = civilite.cle))) LEFT JOIN support ON ((support.cle_personne = personne.cle))), grade, typesupport, employeur' rule: #fromClause