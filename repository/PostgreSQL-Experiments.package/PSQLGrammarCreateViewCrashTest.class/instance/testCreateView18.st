as yet unclassified
testCreateView18
	self
		parse: 'CREATE VIEW vue_support_le_plus_ancien AS SELECT premierssupports.cle_personne, premierssupports.min, support.cle AS clesupport FROM (SELECT support.cle_personne, min(support.debut) AS min FROM support GROUP BY support.cle_personne) premierssupports, support WHERE ((support.cle_personne = premierssupports.cle_personne) AND (support.debut = premierssupports.min))' rule: #createViewCommand