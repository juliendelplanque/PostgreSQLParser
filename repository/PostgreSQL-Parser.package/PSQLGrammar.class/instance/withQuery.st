select command
withQuery
	^ identifier trim ,
	  		(openParenthesis trim ,
			(identifierOrKeyword separatedBy: comma trim ) ,
			closeParenthesis trim) optional ,
	  kw as trim ,
	  openParenthesis trim ,
	  (selectCommand / insertCommand / updateCommand / deleteCommand) ,
	  closeParenthesis trim