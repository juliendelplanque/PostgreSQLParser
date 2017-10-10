expression
compositeValueWith: anExpressionParser
	^ openParenthesis trim , (anExpressionParser plus separatedBy: comma trim) , closeParenthesis trim , typeCastConstruct trim optional