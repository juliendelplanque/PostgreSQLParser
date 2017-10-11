expression
aggregateExpressionParserWith: expressionParser
	^ aggregateName , (openParenthesis ,
		(asterik /
		 ((kw all / kw distinct) optional,
		 (expressionParser plus separatedBy: comma trim) , orderByClause )),
	closeParenthesis)