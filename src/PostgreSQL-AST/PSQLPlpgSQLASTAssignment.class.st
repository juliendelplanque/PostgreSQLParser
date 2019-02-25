"
I represent an assignment in PL/pgSQL.
"
Class {
	#name : #PSQLPlpgSQLASTAssignment,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'target',
		'toAssign',
		'operator'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTAssignment >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTAssignment: self
]

{ #category : #testing }
PSQLPlpgSQLASTAssignment >> isAssignment [
	^ true
]

{ #category : #accessing }
PSQLPlpgSQLASTAssignment >> operator [
	^ operator
]

{ #category : #accessing }
PSQLPlpgSQLASTAssignment >> operator: anObject [
	operator := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTAssignment >> target [
	^ target
]

{ #category : #accessing }
PSQLPlpgSQLASTAssignment >> target: anObject [
	target := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTAssignment >> toAssign [
	^ toAssign
]

{ #category : #accessing }
PSQLPlpgSQLASTAssignment >> toAssign: anObject [
	toAssign := anObject
]
