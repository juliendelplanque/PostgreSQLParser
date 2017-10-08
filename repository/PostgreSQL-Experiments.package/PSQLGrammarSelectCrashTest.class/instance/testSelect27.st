tests
testSelect27
	self
		parse: 'SELECT personne.cle, personne.nom, personne.prenom, date_trunc(''day''::text, ((support.debut)::timestamp with time zone - now())) AS delai, support.cle AS clesupport, support.debut FROM personne, support WHERE (((personne.cle = support.cle_personne) AND (((support.debut)::timestamp with time zone - now()) > ''00:00:00''::interval)) AND (((support.debut)::timestamp with time zone - now()) < ''30 days''::interval)) GROUP BY personne.cle, personne.nom, personne.prenom, support.cle, support.debut' rule: #selectCommand