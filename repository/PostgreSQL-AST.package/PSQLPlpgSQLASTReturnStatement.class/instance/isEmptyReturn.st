testing
isEmptyReturn
	"Returns true if I represent a statement with the form 'RETURN'."
	^ self expression isNil and: [ self isReturnNext not and: [ self query isNil and: [ self queryExecute isNil and: [ self usingExpressions isNil ] ] ] ]