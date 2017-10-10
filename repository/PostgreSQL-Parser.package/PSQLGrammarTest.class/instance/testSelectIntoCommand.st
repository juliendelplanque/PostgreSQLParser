tests-select command
testSelectIntoCommand
	self
		parse: 'SELECT equipe.cle INTO cleequipe FROM personne,affectation,support,equipe WHERE personne.cle = clepersonne::int4 AND clepersonne::int4 = personne.cle AND	abandon::bool = FALSE AND support.cle_personne = personne.cle AND affectation.cle_support = support.cle AND affectation.cle_equipe = equipe.cle AND (dateobservation::date > affectation.debut AND (dateobservation::date <= affectation.fin OR dateobservation::date <= (affectation.fin + ''1 YEAR''::INTERVAL)))' rule: #selectIntoCommand;
		parse: 'SELECT cle INTO clepersonne FROM personne WHERE uidpersonne = uid' rule: #selectIntoCommand