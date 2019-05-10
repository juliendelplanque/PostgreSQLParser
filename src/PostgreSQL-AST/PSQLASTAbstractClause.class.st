Class {
	#name : #PSQLASTAbstractClause,
	#superclass : #PSQLASTNode,
	#category : #'PostgreSQL-AST-SQL-Clauses'
}

{ #category : #testing }
PSQLASTAbstractClause >> isClause [
	^ true
]
