tests
testSelect20
	self
		parse: 'SELECT premierssupports.cle_personne, premierssupports.min, support.cle AS clesupport FROM (SELECT support.cle_personne, min(support.debut) AS min FROM support GROUP BY support.cle_personne) premierssupports, support WHERE ((support.cle_personne = premierssupports.cle_personne) AND (support.debut = premierssupports.min))' rule: #selectCommand