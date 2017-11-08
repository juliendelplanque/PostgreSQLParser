"
I am an abstract conditional statement, I define #conditionToStatements to hold associations with a boolean expression as #head and a list of statements as #tail and #elseStatements holding a list of statements for the else clause.
"
Class {
	#name : #PSQLPlpgSQLASTConditional,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'conditionToStatements',
		'elseStatements'
	],
	#category : 'PostgreSQL-AST-Nodes'
}

{ #category : #accessing }
PSQLPlpgSQLASTConditional >> conditionToStatements [
	^ conditionToStatements
]

{ #category : #accessing }
PSQLPlpgSQLASTConditional >> conditionToStatements: anObject [
	conditionToStatements := anObject
]

{ #category : #accessing }
PSQLPlpgSQLASTConditional >> elseStatements [
	^ elseStatements
]

{ #category : #accessing }
PSQLPlpgSQLASTConditional >> elseStatements: anObject [
	elseStatements := anObject
]
