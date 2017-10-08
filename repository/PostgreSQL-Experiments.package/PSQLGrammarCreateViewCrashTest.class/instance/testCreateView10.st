as yet unclassified
testCreateView10
	self
		parse: 'CREATE VIEW vue_employeurs AS SELECT support.cle AS clesupport, employeur.nom AS nomemployeur FROM (support JOIN employeur ON ((employeur.cle = support.cle_employeur)))' rule: #createViewCommand