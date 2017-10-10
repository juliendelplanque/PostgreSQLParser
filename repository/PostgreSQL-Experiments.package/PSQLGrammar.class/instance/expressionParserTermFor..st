expression
expressionParserTermFor: expressionParser
	| parenthesedExpression functionCall aggregateExpression |
	parenthesedExpression := self parenthesedExpressionParserWith: expressionParser.
	functionCall := self functionCallParserWith: expressionParser.
	aggregateExpression := self aggregateExpressionParserWith: expressionParser.
	^ (parenthesedExpression / conditionalExpression / aggregateExpression / functionCall / primary / selectCommand) , typeCastConstruct optional.