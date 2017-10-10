tests
testSelect43
	self
		parse: 'SELECT DISTINCT plateforme.cle, plateforme.nom, plateforme.description, plateforme.description_en, plateforme.siteweb, personne.nom AS resp_nom, personne.prenom AS resp_prenom FROM (plateforme LEFT JOIN personne ON ((plateforme.cle_responsable = personne.cle)))' rule: #selectCommand