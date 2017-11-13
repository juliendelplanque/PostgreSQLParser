"
I am an abstract superclass for class representing node of one of the CRUD queries (i.e. INSERT, SELECT, UPDATE and DELETE).
"
Class {
	#name : #PSQLASTCRUDQuery,
	#superclass : #PSQLASTNode,
	#instVars : [
		'withClause'
	],
	#category : #PostgreSQL-AST-Nodes
}

{ #category : #testing }
PSQLASTCRUDQuery >> hasWithClause [
	^ self withClause isNotNil
]

{ #category : #accessing }
PSQLASTCRUDQuery >> withClause [
	^ withClause
]

{ #category : #accessing }
PSQLASTCRUDQuery >> withClause: anObject [
	withClause := anObject
]
