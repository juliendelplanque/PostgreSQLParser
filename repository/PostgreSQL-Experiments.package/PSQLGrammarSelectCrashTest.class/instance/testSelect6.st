tests
testSelect6
	self
		parse: 'SELECT personne.cle, (((personne.nom)::text || '' ''::text) || (personne.prenom)::text) AS nomprenom FROM personne ORDER BY personne.nom, personne.prenom' rule: #selectCommand