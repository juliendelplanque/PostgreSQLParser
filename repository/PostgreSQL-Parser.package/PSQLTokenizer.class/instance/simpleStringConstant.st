accessing
simpleStringConstant
	^ $' asParser, ('\''' asParser / $' asParser negate) star , $' asParser