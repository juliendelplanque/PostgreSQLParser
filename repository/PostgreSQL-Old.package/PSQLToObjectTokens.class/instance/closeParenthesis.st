accessing
closeParenthesis
	^ super closeParenthesis ==> [ :items |
		PSQLCloseParenthesis new ]