as yet unclassified
testCreateView15
	self
		parse: 'CREATE VIEW vue_support_le_plus_recent AS SELECT recents.clepersonne, support.cle AS clesupport, recents.debutsupport FROM support, (SELECT support.cle_personne AS clepersonne, max(support.debut) AS debutsupport FROM support GROUP BY support.cle_personne) recents WHERE ((support.cle_personne = recents.clepersonne) AND (support.debut = recents.debutsupport)) ORDER BY recents.clepersonne' rule: #createViewCommand