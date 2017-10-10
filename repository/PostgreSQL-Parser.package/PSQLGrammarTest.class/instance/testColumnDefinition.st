tests
testColumnDefinition
	self
		parse: 'clepersonne INTEGER' rule: #columnDefinition;
		parse: 'datearrivee DATE' rule: #columnDefinition;
		parse: 'sexe VARCHAR' rule: #columnDefinition