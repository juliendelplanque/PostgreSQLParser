"
I am SET clause item of type 1. See PSQLGrammar>>#setItem1.
"
Class {
	#name : #PSQLASTSetClauseItemType1,
	#superclass : #PSQLASTSetClauseItem,
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTSetClauseItemType1 >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTSetClauseItemType1: self
]
