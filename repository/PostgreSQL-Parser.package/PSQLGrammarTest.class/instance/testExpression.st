tests-expression
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
		parse: '(personne.cle IN (SELECT these.cle_coencadrant FROM these))' rule: #expression;
		parse: '''IG''::character varying' rule: #expression;
		parse: '1 = - 1' rule: #expression;
		parse: 'ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text])' rule: #expression;
		parse: '((grade.cle_catgrade)::text = ANY (ARRAY[(''IG''::character varying)::text, (''TECH''::character varying)::text]))' rule: #expression;
		parse: '''a'' || ''b''' rule: #expression;
		parse: 'parentid IS NULL OR parentid = ''''' rule: #expression;
		parse: 'x BETWEEN 0 AND 10' rule: #expression;
		parse: 'x NOT BETWEEN 0 AND 10' rule: #expression;
		parse: '(x BETWEEN 0 AND 10) OR (x NOT BETWEEN 15 AND 20)' rule: #expression;
		parse: 'x IS DISTINCT FROM y' rule: #expression;
		parse: 'x IS NOT DISTINCT FROM y' rule: #expression;
		parse: 'x IS TRUE' rule: #expression;
		parse: 'x IS NOT TRUE' rule: #expression;
		parse: 'x IS FALSE' rule: #expression;
		parse: 'x IS NOT FALSE' rule: #expression;
		parse: 'x IS UNKNOWN' rule: #expression;
		parse: 'x IS NOT UNKNOWN' rule: #expression;
		parse: 'x BETWEEN SYMMETRIC 0 AND 10' rule: #expression;
		parse: 'x NOT BETWEEN SYMMETRIC 0 AND 10' rule: #expression;
		parse: '"matrix_p"["i"]["j"] > "matrix_p"["j"]["i"]'  rule: #expression;
		parse: '((-1::INT8) << 63, 0)::"link_strength"' rule: #expression;
		fail: 'a..nbrspechar' rule: #expression