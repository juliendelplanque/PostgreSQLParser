"
I represent the type of a variable in a PL/pgSQL procedure.
"
Class {
	#name : #PSQLPlpgSQLASTType,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'identifier',
		'size',
		'dimensions'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTType >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTType: self
]

{ #category : #accessing }
PSQLPlpgSQLASTType >> dimensions [
	^ dimensions
]

{ #category : #accessing }
PSQLPlpgSQLASTType >> dimensions: anObject [
	dimensions := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTType >> identifier [
	^ identifier
]

{ #category : #accessing }
PSQLPlpgSQLASTType >> identifier: anObject [
	identifier := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTType >> size [
	^ size
]

{ #category : #accessing }
PSQLPlpgSQLASTType >> size: anObject [
	size := anObject
]
