tests
testSelect4
	self
		parse: 'SELECT calcule_age(datenaissance,dateobservation::date)::INTEGER AS age, SUM(est_un_homme(civilite))::INTEGER AS homme, SUM(est_une_femme(civilite))::INTEGER AS femme FROM personne,support WHERE personne.cle = support.cle_personne AND (support.debut <= dateobservation AND (support.fin >= dateobservation OR support.fin IS NULL)) AND datenaissance IS NOT NULL GROUP BY age ORDER BY age' rule: #selectCommand