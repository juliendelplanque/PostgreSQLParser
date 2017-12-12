"
I represent a 'ON CONFLICT' clause.
"
Class {
	#name : #PSQLASTOnConflictClause,
	#superclass : #PSQLASTNode,
	#instVars : [
		'target',
		'action'
	],
	#category : #'PostgreSQL-AST-SQL'
}

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

{ #category : #accessing }
PSQLASTOnConflictClause >> target [
	^ target
]

{ #category : #accessing }
PSQLASTOnConflictClause >> target: anObject [
	target := anObject
]
