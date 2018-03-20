"
I visit the JSON model to build PSQLASTLQCreateFunction.
"
Class {
	#name : #PSQLLQCreateFunctionVisitor,
	#superclass : #PSQLJSONVisitor,
	#category : #PostgreSQL-LibpgQuery-Visitors
}

{ #category : #visiting }
PSQLLQCreateFunctionVisitor >> ensureBody: createFunctionNode from: aDictionary [
	| bodyASTDict |
	bodyASTDict := ((aDictionary at: 'options') detect: [ :dict | ((dict at: 'DefElem') at: 'defname') = 'as' ]) at: 'DefElem'.
	createFunctionNode body: (PSQLASTBuilder new plpgsqlBody
										parse: (bodyASTDict at: 'arg') first extractString trimmed psqlRemoveComments
										onError: [ :ppFailure | self error: 'Function parsing failed.' ]).
]

{ #category : #visiting }
PSQLLQCreateFunctionVisitor >> ensureIdentifier: createFunctionNode from: aDictionary. [
	createFunctionNode identifier: (self convertToIdentifierOrAttributeAccess: (aDictionary at: 'funcname') extractString)
]

{ #category : #visiting }
PSQLLQCreateFunctionVisitor >> ensureLanguage: createFunctionNode from: aDictionary [
	| languageDict |
	languageDict := ((aDictionary at: 'options') detect: [ :dict | ((dict at: 'DefElem') at: 'defname') = 'language' ]) at: 'DefElem'.
	createFunctionNode language: (PSQLASTIdentifier new
												identifier: (languageDict at: 'arg') extractString;
												yourself).
]

{ #category : #visiting }
PSQLLQCreateFunctionVisitor >> ensureParameters: createFunctionNode from: aDictionary [
	| parameters |
	parameters := (aDictionary at: 'parameters' ifAbsent: [ createFunctionNode parameters: #(). ^ self ]) collect: [ :subDict |
						PSQLASTLQFunctionParameter new
							identifier: (PSQLASTIdentifier new
												identifier: ((subDict at: 'FunctionParameter') at: 'name');
												yourself);
							typeIdentifier: (((subDict at: 'FunctionParameter') at: 'argType') extractString psqlJSONAccept: PSQLTypeNameExtractor new);
							yourself ].
					
	createFunctionNode parameters: parameters
]

{ #category : #visiting }
PSQLLQCreateFunctionVisitor >> ensureReturnType: createFunctionNode from: aDictionary [
	createFunctionNode
		returnType: ((aDictionary at: 'returnType') extractString psqlJSONAccept: PSQLTypeNameExtractor new)
]

{ #category : #visiting }
PSQLLQCreateFunctionVisitor >> visitDictionary: aDictionary [
	| createFunctionNode |
	createFunctionNode := PSQLASTLQCreateFunction new.
	self
		ensureIdentifier: createFunctionNode from: aDictionary;
		ensureBody: createFunctionNode from: aDictionary;
		ensureParameters: createFunctionNode from: aDictionary;
		ensureReturnType: createFunctionNode from: aDictionary;
		ensureLanguage: createFunctionNode from: aDictionary.

	^ createFunctionNode
]
