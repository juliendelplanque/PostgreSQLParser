"
I am SET clause item of type 3. See PSQLGrammar>>#setItem3.
"
Class {
	#name : #PSQLASTSetClauseItemType3,
	#superclass : #PSQLASTSetClauseItem,
	#category : #PostgreSQL-AST-SQL
}

{ #category : #visiting }
PSQLASTSetClauseItemType3 >> acceptVisitor: aPSQLASTVisitor [
	^ self visitPSQLASTSetClauseItemType3: self
]