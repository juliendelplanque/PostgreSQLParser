"
I represent a 'ON CONFLICT' clause.
"
Class {
	#name : #PSQLASTOnConflictClause,
	#superclass : #PSQLASTAbstractClause,
	#instVars : [
		'target',
		'action'
	],
	#category : #'PostgreSQL-AST-SQL-Clauses'
}

{ #category : #visiting }
PSQLASTOnConflictClause >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTOnConflictClause: self
]

{ #category : #accessing }
PSQLASTOnConflictClause >> action [
	^ action
]

{ #category : #accessing }
PSQLASTOnConflictClause >> action: anObject [
	action := anObject
]

{ #category : #testing }
PSQLASTOnConflictClause >> hasTarget [
	^ self target isNotNil
]

{ #category : #testing }
PSQLASTOnConflictClause >> isOnConflictClause [
	^ true
]

{ #category : #accessing }
PSQLASTOnConflictClause >> target [
	^ target
]

{ #category : #accessing }
PSQLASTOnConflictClause >> target: anObject [
	target := anObject
]
