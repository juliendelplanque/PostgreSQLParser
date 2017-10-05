tests-select command
testWhereClause
	self
		parse: 'WHERE 1 + 1 = 2' rule: #whereClause;
		parse: 'WHERE table.id = 42' rule: #whereClause;
		parse: 'WHERE fct(table)  = ''test''' rule: #whereClause;
		parse: 'WHERE personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL' rule: #whereClause