select command
fromItems3
	"with_query_name [ [ AS ] alias [ ( column_alias [, ...] ) ] ]"
	^ queryName , (
			as trim optional , alias , 
			(openParenthesis trim,
			(columnAlias separatedBy: comma trim),
			closeParenthesis trim) optional) optional