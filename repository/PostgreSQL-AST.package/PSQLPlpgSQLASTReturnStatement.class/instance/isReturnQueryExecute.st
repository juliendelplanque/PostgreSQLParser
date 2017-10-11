testing
isReturnQueryExecute
	"Returns true if I represent a statement with the form 'RETURN QUERY EXECUTE command-string [ USING expression [, ... ] ]'."
	^ self queryExecute isNotNil