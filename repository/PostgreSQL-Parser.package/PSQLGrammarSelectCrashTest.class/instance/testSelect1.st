tests
testSelect1
	self
		parse: 'SELECT affectation.debut AS debutaffectation, affectation.fin AS finaffectation FROM affectation,support,personne WHERE affectation.cle_support = support.cle AND	support.cle_personne = personne.cle AND personne.cle = clepersonne AND	affectation.cle_equipe = cleequipe AND affectation.fin <= finperiode ORDER BY affectation.debut' rule: #selectCommand