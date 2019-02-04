"
I am the implementation of the facade design pattern to expose the parser to users in a simplied way.

See my class side for available methods.
"
Class {
	#name : #PostgreSQLParser,
	#superclass : #Object,
	#category : #'PostgreSQL-Facade'
}

{ #category : #parsing }
PostgreSQLParser class >> parseCRUDQuery: aQueryString [
	"Parses a CRUD query provided as a string and returns a AST well initialized."
	| ast |
	ast := PSQLCRUDQueryASTBuilder parse: aQueryString.
	ast isPetitFailure
		ifTrue: [ PSQLParseError signalPetitFailure: ast ].
	ast setChildrenParent.
	ast sourceCode: aQueryString.
	^ ast
]
