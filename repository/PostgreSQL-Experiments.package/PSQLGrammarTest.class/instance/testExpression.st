tests
testExpression
	self
		parse: 'fct()' rule: #expression;
		parse: '++1' rule: #expression;
		parse: '1+1' rule: #expression;
		parse: '1++' rule: #expression;
		parse: '(fct(fct1(variable[1:$2],2),fct2(42)))' rule: #expression;
		parse: '"initiative"."issue_id" = "interest"."issue_id"' rule: #expression;
		parse: '(id)' rule: #expression;
		parse: '(rowfunction(a,b))' rule: #expression;
		parse: 'affectation.cle_support = support.cle AND support.cle_personne = personne.cle AND personne.cle = clepersonne AND	affectation.cle_equipe = cleequipe AND affectation.fin <= finperiode' rule: #expression;
		parse: 'membres(labo,dateobservation::DATE,dateobservation::DATE)' rule: #expression;
		parse: 'personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL' rule: #expression;
		parse: '(personne.cle IN (SELECT these.cle_coencadrant FROM these))' rule: #expression