tests-select command
testWhereClause
	self
		parse: 'WHERE 1 + 1 = 2' rule: #whereClause;
		parse: 'WHERE table.id = 42' rule: #whereClause;
		parse: 'WHERE fct(table)  = ''test''' rule: #whereClause;
		parse: 'WHERE personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL' rule: #whereClause;
		parse: 'WHERE ((((support.cle_grade = grade.cle) AND (support.cle_typesupport = typesupport.cle)) AND (support.cle_employeur = employeur.cle)) AND ((grade.cle = 27) OR (grade.cle = 17)))' rule: #whereClause;
		parse: 'WHERE (((((((personne.cle = support.cle_personne) AND (support.cle_grade = grade.cle)) AND (support.cle_categorie = categorie.cle)) AND ((categorie.categorie)::text = ''PERMANENT''::text)) AND (support.cle_employeur = employeur.cle)) AND (((((support.cle_employeur = 1) OR (support.cle_employeur = 15)) OR (support.cle_employeur = 2)) OR (support.cle_employeur = 3)) OR (support.cle_employeur = 107))) AND ((grade.cle_catgrade)::text = ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text])))' rule: #whereClause