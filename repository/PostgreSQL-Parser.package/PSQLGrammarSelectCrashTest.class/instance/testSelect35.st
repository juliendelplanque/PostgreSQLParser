tests
testSelect35
	self
		parse: 'SELECT DISTINCT grade.poids, catgrade.sigle, catgrade.intitule FROM (catgrade LEFT JOIN grade ON (((grade.cle_catgrade)::text = (catgrade.sigle)::text))) ORDER BY grade.poids DESC' rule: #selectCommand