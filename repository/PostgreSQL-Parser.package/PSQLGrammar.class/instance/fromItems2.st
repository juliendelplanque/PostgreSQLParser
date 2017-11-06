select command
fromItems2
	"This should be implemented as:
		( select ) [ AS ] alias [ ( column_alias [, ...] ) ]
	But is implemented as:
		( values | select ) [ AS ] alias [ ( column_alias [, ...] ) ]
	since using a VALUES query is just like if a select query is used except
	that the results are defined directly in the query."
	^ openParenthesis trim , (valuesCommand / selectCommand) , closeParenthesis trim , kw as trim optional ,
			alias trim ,
			(openParenthesis trim,
			 (columnAlias separatedBy: comma trim),
			 closeParenthesis trim) optional