expression
aggregateExpressionParserWith: expressionParser
	^ aggregateName , (openParenthesis ,
		(asterik /
		 ((kw all / distinct) optional,
		 (expressionParser plus separatedBy: comma trim) , orderByClause )),
	closeParenthesis)