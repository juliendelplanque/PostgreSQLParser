accessing
fromItems4
	"function_name ( [ argument [, ...] ] ) [ AS ] alias [ ( column_alias [, ...] | column_definition [, ...] ) ]"
	^ functionName ,
		openParenthesis trim,
		(expression separatedBy: comma trim), "Using 'expression' is OK to parse function arguments"
		closeParenthesis trim,
		as trim optional ,
		alias trim,
		(openParenthesis trim ,
			((columnDefinition plus separatedBy: comma trim) / (columnReference plus separatedBy: comma trim)),
		closeParenthesis trim) optional