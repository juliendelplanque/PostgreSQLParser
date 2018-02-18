Class {
	#name : #PSQLPlpgSQLCursorUpdate,
	#superclass : #PSQLPlpgSQLASTCursorStatement,
	#category : #PostgreSQL-AST-PlpgSQL
}

{ #category : #visiting }
PSQLPlpgSQLCursorUpdate >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLPlpgSQLCursorUpdate: self
]
