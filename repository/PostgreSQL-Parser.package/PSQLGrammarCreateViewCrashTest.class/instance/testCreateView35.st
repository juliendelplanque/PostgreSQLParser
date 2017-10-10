as yet unclassified
testCreateView35
	self
		parse: 'CREATE VIEW web_catgrade AS SELECT DISTINCT grade.poids, catgrade.sigle, catgrade.intitule FROM (catgrade LEFT JOIN grade ON (((grade.cle_catgrade)::text = (catgrade.sigle)::text))) ORDER BY grade.poids DESC' rule: #createViewCommand