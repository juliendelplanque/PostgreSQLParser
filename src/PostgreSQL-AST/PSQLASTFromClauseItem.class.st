"
I am an abstract FROM clause item node.
"
Class {
	#name : #PSQLASTFromClauseItem,
	#superclass : #PSQLASTNode,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #testing }
PSQLASTFromClauseItem >> isFromClauseItem [
	^ true
]
