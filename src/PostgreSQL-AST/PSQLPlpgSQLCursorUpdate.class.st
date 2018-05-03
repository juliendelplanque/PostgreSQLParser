Class {
	#name : #PSQLPlpgSQLCursorUpdate,
	#superclass : #PSQLPlpgSQLASTCursorStatement,
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLCursorUpdate >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLCursorUpdate: self
]
