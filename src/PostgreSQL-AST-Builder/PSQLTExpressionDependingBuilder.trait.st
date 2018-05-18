Trait {
	#name : #PSQLTExpressionDependingBuilder,
	#category : #'PostgreSQL-AST-Builder-Traits'
}

{ #category : #accessing }
PSQLTExpressionDependingBuilder classSide >> expressionParser [
	^ PSQLExpressionASTBuilder 
]
