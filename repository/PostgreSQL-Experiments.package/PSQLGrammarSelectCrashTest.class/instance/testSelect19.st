tests
testSelect19
	self
		parse: 'SELECT personne.cle, personne.nom, personne.prenom FROM personne WHERE (personne.cle IN (SELECT these.cle_responsable FROM these))' rule: #selectCommand