tests
testSelect7
	self
		parse: 'SELECT personne.nom AS nompersonne, personne.prenom, affectation.cle_equipe, support.cle_personne, equipe.nom AS nomequipe FROM personne, support, affectation, equipe WHERE ((((equipe.cle = affectation.cle_equipe) AND ((affectation.debut <= now()) AND ((affectation.fin >= now()) OR (affectation.fin IS NULL)))) AND (affectation.cle_support = support.cle)) AND (support.cle_personne = personne.cle))' rule: #selectCommand