tests
testSelect15
	self
		parse: 'SELECT support.cle AS clesupport, employeur.nom AS nomemployeur FROM (support JOIN employeur ON ((employeur.cle = support.cle_employeur)))' rule: #selectCommand