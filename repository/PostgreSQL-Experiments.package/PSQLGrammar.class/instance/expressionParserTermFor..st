expression
expressionParserTermFor: expressionParser
	| parenthesedExpression functionCall aggregateExpression |
	parenthesedExpression := self parenthesedExpressionParserWith: expressionParser.
	functionCall := self functionCallParserWith: expressionParser.
	aggregateExpression := self aggregateExpressionParserWith: expressionParser.
	^ (parenthesedExpression / aggregateExpression / functionCall / primary / selectCommand) , (typeCast trim , (identifierOrKeyword plus separatedBy: #space asParser plus)) optional.