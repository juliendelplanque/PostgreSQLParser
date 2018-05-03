"
I represent the DEFAULT command in insert command VALUES.
"
Class {
	#name : #PSQLASTDefaultValue,
	#superclass : #PSQLASTNode,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTDefaultValue >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTDefaultValue: self
]
