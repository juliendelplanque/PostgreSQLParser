"
I am an abstract superclass for class representing node of one of the CRUD queries (i.e. INSERT, SELECT, UPDATE and DELETE).
"
Class {
	#name : #PSQLASTCRUDQuery,
	#superclass : #PSQLASTNode,
	#instVars : [
		'withClause'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #testing }
PSQLASTCRUDQuery >> hasWithClause [
	^ self withClause isNotNil
]

{ #category : #testing }
PSQLASTCRUDQuery >> isCRUDQuery [
	^ true
]

{ #category : #'as yet unclassified' }
PSQLASTCRUDQuery >> literalNodes [
	^ TreeQuery depthFirst
		collectMatches;
		predicate: #isConstant asTQPredicate;
		runOn: self childrenBlock: #children
]

{ #category : #accessing }
PSQLASTCRUDQuery >> withClause [
	^ withClause
]

{ #category : #accessing }
PSQLASTCRUDQuery >> withClause: anObject [
	withClause := anObject
]
