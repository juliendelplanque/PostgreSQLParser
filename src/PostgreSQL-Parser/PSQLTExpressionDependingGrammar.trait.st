Trait {
	#name : #PSQLTExpressionDependingGrammar,
	#category : #'PostgreSQL-Parser-DependenciesTraits'
}

{ #category : #accessing }
PSQLTExpressionDependingGrammar classSide >> expressionParser [
	^ PSQLExpressionGrammar
]

{ #category : #expression }
PSQLTExpressionDependingGrammar >> expressionParser [
	^ (self dependencyAt: self class expressionParser)
]

{ #category : #expression }
PSQLTExpressionDependingGrammar >> whenExpression [
	^ self expressionParser whenExpression
]
