"
I am the AST node for a PERFORM statements.
"
Class {
	#name : #PSQLPlpgSQLASTPerform,
	#superclass : #PSQLPlpgSQLASTNode,
	#instVars : [
		'code'
	],
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTPerform >> acceptVisitor: aPSQLASTReflectiveVisitor [ 
	^ aPSQLASTReflectiveVisitor visitPSQLPlpgSQLASTPerform: self
]

{ #category : #accessing }
PSQLPlpgSQLASTPerform >> code [
	^ code
]

{ #category : #accessing }
PSQLPlpgSQLASTPerform >> code: anObject [
	code := anObject
]
