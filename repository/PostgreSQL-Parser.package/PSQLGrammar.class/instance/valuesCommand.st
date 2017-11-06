values command
valuesCommand
	"This should implement:
		VALUES ( expression [, ...] ) [, ...]
	But it implements:
		VALUES ( { expression | DEFAULT } [, ...] )
	instead in order to be reusable in #insertCommand.
	
	Please manage this fact while building the AST."
	
	^ kw values trim ,
	((openParenthesis trim,
		((kw default / expression) plus separatedBy: comma trim) ,
	closeParenthesis trim) plus separatedBy: comma trim)