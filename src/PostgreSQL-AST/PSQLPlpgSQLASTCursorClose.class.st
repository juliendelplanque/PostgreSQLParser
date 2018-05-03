"
I represent a CLOSE cursor statement.
"
Class {
	#name : #PSQLPlpgSQLASTCursorClose,
	#superclass : #PSQLPlpgSQLASTCursorStatement,
	#category : #'PostgreSQL-AST-PlpgSQL'
}

{ #category : #visiting }
PSQLPlpgSQLASTCursorClose >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLPlpgSQLASTCursorClose: self
]
