"
I am an abstract AST node of a PL/pgSQL procedure.
"
Class {
	#name : #PSQLPlpgSQLASTNode,
	#superclass : #PSQLASTNode,
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #accessing }
PSQLPlpgSQLASTNode >> classNameWithoutPrefix [
	^ self className allButFirst: 13
]
