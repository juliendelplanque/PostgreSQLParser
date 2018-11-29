"
I model a condition which, if evaluates to true, leads to the statements to be evaluated.
"
Class {
	#name : #PSQLPlpgSQLASTConditionToStatements,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'condition',
		'statements'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #'instance creation' }
PSQLPlpgSQLASTConditionToStatements class >> condition: aPSQLASTNode statements: statements [
	^ self new
		condition: aPSQLASTNode;
		statements: statements;
		yourself
]

{ #category : #visiting }
PSQLPlpgSQLASTConditionToStatements >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTConditionToStatements: self
]

{ #category : #accessing }
PSQLPlpgSQLASTConditionToStatements >> condition [
	^ condition
]

{ #category : #accessing }
PSQLPlpgSQLASTConditionToStatements >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTConditionToStatements >> statements [
	^ statements
]

{ #category : #accessing }
PSQLPlpgSQLASTConditionToStatements >> statements: anObject [
	statements := anObject
]
