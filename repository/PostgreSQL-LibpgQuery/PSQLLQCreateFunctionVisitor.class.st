Class {
	#name : #PSQLLQCreateFunctionVisitor,
	#superclass : #PSQLJSONVisitor,
	#category : #PostgreSQL-LibpgQuery-Visitors
}

{ #category : #visiting }
PSQLLQCreateFunctionVisitor >> visitDictionary: aDictionary [
	| functionIdentifier bodyAST bodyASTDict |
	functionIdentifier := self convertToIdentifierOrAttributeAccess: (aDictionary at: 'funcname').
	
	bodyASTDict := ((aDictionary at: 'options') detect: [ :dict | ((dict at: 'DefElem') at: 'defname') = 'as' ]) at: 'DefElem'.
	bodyAST := PSQLASTBuilder new plpgsqlBody
					parse: (bodyASTDict at: 'arg') first trimmed psqlRemoveComments
					onError: [ :ppFailure | self error: 'Function parsing failed.' ].
	self flag: 'TODO gather the other informations.'.
	
	^ PSQLASTLQCreateFunction new
		identifier: functionIdentifier;
		body: bodyAST;
		yourself
]
