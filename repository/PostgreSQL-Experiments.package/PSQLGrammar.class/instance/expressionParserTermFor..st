expression
expressionParserTermFor: expressionParser
	| parenthesedExpression functionCall aggregateExpression compositeValue |
	parenthesedExpression := self parenthesedExpressionParserWith: expressionParser.
	functionCall := self functionCallParserWith: expressionParser.
	aggregateExpression := self aggregateExpressionParserWith: expressionParser.
	compositeValue := self compositeValueWith: expressionParser.
	^ (parenthesedExpression / compositeValue / conditionalExpression / aggregateExpression / functionCall / primary / selectCommand) , typeCastConstruct optional.