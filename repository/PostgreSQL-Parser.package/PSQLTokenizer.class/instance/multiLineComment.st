accessing
multiLineComment
	^ '/*' asParser , (multiLineComment / '*/' asParser negate) star , '*/' asParser