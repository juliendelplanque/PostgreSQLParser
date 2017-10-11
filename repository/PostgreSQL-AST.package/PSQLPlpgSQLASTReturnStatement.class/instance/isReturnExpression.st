testing
isReturnExpression
	"Returns true if I represent a statement with the form 'RETURN expression'."
	^ self isReturnNext not and: [ self expression isNotNil ]