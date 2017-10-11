testing
isReturnQuery
	"Returns true if I represent a statement with the form 'RETURN QUERY query'."
	^ self query isNotNil