tests
testSelectCommand
	self
		parse: 'SELECT 1 + 1' rule: #selectCommand;
		parse: 'SELECT DISTINCT ON (id, name) *' rule: #selectCommand;
		parse: 'SELECT DISTINCT ON (id, name) result, other, onemore' rule: #selectCommand;
		parse: 'SELECT ALL id, name, test AS result, other, onemore' rule: #selectCommand;
		parse: 'SELECT count(id) FROM table1' rule: #selectCommand;
		parse: 'SELECT affectation.debut AS debutaffectation, affectation.fin AS finaffectation FROM affectation,support,personne WHERE affectation.cle_support = support.cle AND	support.cle_personne = personne.cle AND personne.cle = clepersonne AND	affectation.cle_equipe = cleequipe AND affectation.fin <= finperiode ORDER BY affectation.debut' rule: #selectCommand