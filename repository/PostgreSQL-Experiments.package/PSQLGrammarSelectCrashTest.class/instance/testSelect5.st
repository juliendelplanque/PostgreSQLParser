tests
testSelect5
	self
		parse: 'SELECT support.cle, support.debut, support.fin FROM support WHERE support.cle_personne = clepersonne' rule: #selectCommand