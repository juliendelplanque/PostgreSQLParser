expression
functionCallParserWith: expressionParser
	^ functionName , (openParenthesis trim , 
		(((functionParameterName , ':=' asParser trim , expressionParser) trim / expressionParser trim) star separatedBy: comma trim) , 
		closeParenthesis trim)