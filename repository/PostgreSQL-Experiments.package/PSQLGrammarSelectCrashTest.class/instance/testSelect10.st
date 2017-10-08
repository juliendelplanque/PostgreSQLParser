tests
testSelect10
	self
		parse: 'SELECT personne.cle, personne.nom, personne.prenom FROM personne WHERE (personne.cle IN (SELECT these.cle_coencadrant FROM these))' rule: #selectCommand