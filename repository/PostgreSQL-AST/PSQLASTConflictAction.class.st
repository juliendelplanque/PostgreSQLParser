"
I am a conflict action in the 'ON CONFLICT' clause of an INSERT query.
"
Class {
	#name : #PSQLASTConflictAction,
	#superclass : #PSQLASTNode,
	#instVars : [
		'setClause',
		'condition'
	],
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTConflictAction >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTConflictAction: self
]

{ #category : #accessing }
PSQLASTConflictAction >> condition [
	^ condition
]

{ #category : #accessing }
PSQLASTConflictAction >> condition: anObject [
	condition := anObject
]

{ #category : #testing }
PSQLASTConflictAction >> hasCondition [
	^ self condition isNotNil
]

{ #category : #testing }
PSQLASTConflictAction >> hasSetClause [
	^ self setClause isNotNil
]

{ #category : #testing }
PSQLASTConflictAction >> isDoNothing [
	^ self hasSetClause not and: [ self hasCondition not ]
]

{ #category : #testing }
PSQLASTConflictAction >> isDoUpdateSet [
	^ self isDoNothing not
]

{ #category : #accessing }
PSQLASTConflictAction >> setClause [
	^ setClause
]

{ #category : #accessing }
PSQLASTConflictAction >> setClause: anObject [
	setClause := anObject
]
