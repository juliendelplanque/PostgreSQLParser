as yet unclassified
testCreateView43
	self
		parse: 'CREATE VIEW web_plateforme AS SELECT DISTINCT plateforme.cle, plateforme.nom, plateforme.description, plateforme.description_en, plateforme.siteweb, personne.nom AS resp_nom, personne.prenom AS resp_prenom FROM (plateforme LEFT JOIN personne ON ((plateforme.cle_responsable = personne.cle)))' rule: #createViewCommand