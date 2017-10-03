accessing
stringConstantWithUnicodeEscape
	^ 'U&''' asParser , ('\''' asParser / $' asParser negate) star , $' asParser