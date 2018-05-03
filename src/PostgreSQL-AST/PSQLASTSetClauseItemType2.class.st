"
I am SET clause item of type 2. See PSQLGrammar>>#setItem2.
"
Class {
	#name : #PSQLASTSetClauseItemType2,
	#superclass : #PSQLASTSetClauseItem,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTSetClauseItemType2 >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTSetClauseItemType2: self
]
