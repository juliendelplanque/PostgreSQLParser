as yet unclassified
testCreateView36
	self
		parse: 'CREATE VIEW web_equipes_emergentes AS SELECT equipe.nom, equipe.siteweb, equipe.nomlong, equipe.nomlong_en, equipe.description, equipe.description_en, personne.nom AS chefnom, personne.prenom AS chefprenom, equipe.cle AS eid FROM ((equipe LEFT JOIN chefequipe ON ((chefequipe.cle_equipe = equipe.cle))) LEFT JOIN personne ON ((personne.cle = chefequipe.cle_personne))) WHERE ((equipe.cle_type_equipe = 2) AND ((equipe.fin <= now()) OR (equipe.fin IS NULL)))' rule: #createViewCommand