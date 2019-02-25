"
I am SET clause item of type 3. See PSQLGrammar>>#setItem3.
"
Class {
	#name : #PSQLASTSetClauseItemType3,
	#superclass : #PSQLASTSetClauseItem,
	#category : #'PostgreSQL-AST-SQL'
}

{ #category : #visiting }
PSQLASTSetClauseItemType3 >> acceptVisitor: aVisitor [
	^ aVisitor visitPSQLASTSetClauseItemType3: self
]

{ #category : #testing }
PSQLASTSetClauseItemType3 >> isSetClauseItemType3 [
	^ true
]
