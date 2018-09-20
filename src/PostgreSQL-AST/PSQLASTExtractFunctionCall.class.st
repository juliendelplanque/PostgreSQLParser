"
I am the node for a special function call (EXTRACT) that have specific parameters
"
Class {
	#name : #PSQLASTExtractFunctionCall,
	#superclass : #PSQLASTNode,
	#instVars : [
		'parameter'
	],
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTExtractFunctionCall >> acceptVisitor: aPSQLASTVisitor [
	^ aPSQLASTVisitor visitPSQLASTExtractFunctionCall: self
]

{ #category : #accessing }
PSQLASTExtractFunctionCall >> parameter [
	^ parameter
]

{ #category : #accessing }
PSQLASTExtractFunctionCall >> parameter: anObject [
	parameter := anObject
]
