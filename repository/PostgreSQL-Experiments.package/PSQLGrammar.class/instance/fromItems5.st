select command
fromItems5
	"function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] )"
	^ functionName ,
		openParenthesis trim,
		(expression separatedBy: comma trim), "Using 'expression' is OK to parse function arguments"
		closeParenthesis trim,
		as trim ,
		(openParenthesis trim ,
			(columnReference separatedBy: comma trim),
		closeParenthesis trim)