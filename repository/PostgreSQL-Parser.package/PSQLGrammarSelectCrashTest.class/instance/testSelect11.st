tests
testSelect11
	self
		parse: 'SELECT equipe.cle AS cleequipe, personne.nom AS nompersonne, personne.prenom AS prenompersonne, equipe.nom AS nomequipe, equipe.debut AS debutequipe, equipe.fin AS finequipe, affectation.debut AS debutaffectation, affectation.fin AS finaffectation FROM affectation, equipe, support, personne WHERE ((((affectation.cle_equipe = equipe.cle) AND (((affectation.debut > equipe.fin) OR (affectation.debut < equipe.debut)) OR (affectation.fin > equipe.fin))) AND (affectation.cle_support = support.cle)) AND (support.cle_personne = personne.cle))' rule: #selectCommand