"
I am an abstract AST node of a PostgreSQL expression.
"
Class {
	#name : #PSQLASTExpressionASTNode,
	#superclass : #PSQLASTNode,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #testing }
PSQLASTExpressionASTNode >> isExpressionASTNode [
	^ true
]
