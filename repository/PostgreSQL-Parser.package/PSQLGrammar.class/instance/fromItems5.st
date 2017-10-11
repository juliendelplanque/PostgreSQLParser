accessing
fromItems5
	"function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] )"
	^ functionName ,
		openParenthesis trim,
		(expression separatedBy: comma trim), "Using 'expression' is OK to parse function arguments"
		closeParenthesis trim,
		kw as trim ,
		(openParenthesis trim ,
			(columnDefinition plus separatedBy: comma trim),
		closeParenthesis trim) optional