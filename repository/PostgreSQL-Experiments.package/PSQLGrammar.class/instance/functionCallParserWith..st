expression
functionCallParserWith: expressionParser
	^ functionName , (openParenthesis , 
		(((functionParameterName , ':=' asParser trim , expressionParser) / expressionParser) star separatedBy: comma trim) , 
		closeParenthesis)