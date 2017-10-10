tests
testSelect28
	self
		parse: 'SELECT personne.cle, personne.nom, personne.prenom, date_trunc(''day''::text, (now() - (support.debut)::timestamp with time zone)) AS delai, support.cle AS clesupport, support.debut FROM personne, support WHERE (((personne.cle = support.cle_personne) AND ((now() - (support.debut)::timestamp with time zone) > ''00:00:00''::interval)) AND ((now() - (support.debut)::timestamp with time zone) < ''30 days''::interval)) GROUP BY personne.cle, personne.nom, personne.prenom, support.cle, support.debut' rule: #selectCommand