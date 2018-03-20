"
I am the node representing an IF-based conditional statement.
"
Class {
	#name : #PSQLPlpgSQLASTIf,
	#superclass : #PSQLPlpgSQLASTConditional,
	#category : #PostgreSQL-AST-PlpgSQL
}

{ #category : #visiting }
PSQLPlpgSQLASTIf >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLPlpgSQLASTIf: self
]
