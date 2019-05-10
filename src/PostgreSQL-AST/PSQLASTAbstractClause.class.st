Class {
	#name : #PSQLASTAbstractClause,
	#superclass : #PSQLASTNode,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #testing }
PSQLASTAbstractClause >> isClause [
	^ true
]
