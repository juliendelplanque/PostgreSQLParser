accessing
columnReference
	^ super columnReference ==> [ :tokens |
		tokens first ifNotNil: [ 
			PSQLASTAttributeAccess new
				identifier: tokens first first;
				attributeIdentifier: tokens second;
				yourself ]
			ifNil: [ 
				tokens second ] ]