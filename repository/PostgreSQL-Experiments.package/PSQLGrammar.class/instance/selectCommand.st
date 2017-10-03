select command
selectCommand
	"[ WITH [ RECURSIVE ] with_query [, ...] ]
	 SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
    	* | expression [ [ AS ] output_name ] [, ...]
    	[ FROM from_item [, ...] ]
    	[ WHERE condition ]
    	[ GROUP BY expression [, ...] ]
    	[ HAVING condition [, ...] ]
    	[ WINDOW window_name AS ( window_definition ) [, ...] ]
    	[ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] select ]
    	[ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
    	[ LIMIT { count | ALL } ]
    	[ OFFSET start [ ROW | ROWS ] ]
    	[ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
    	[ FOR { UPDATE | SHARE } [ OF table_name [, ...] ] [ NOWAIT ] [...] ]"
	^ withClause optional ,
	  select trim ,
	  		(all trim /
			(distinct trim ,
				(on trim ,
					openParenthesis trim ,
					(expression separatedBy: comma trim) trim,
					closeParenthesis) optional )
			) optional ,
			((asterik / expression) separatedBy: comma trim) ,
			(as trim , (columnAlias separatedBy: comma trim)) optional,
		fromClause optional ,
		whereClause optional ,
		groupByClause optional ,
		havingClause optional ,
		windowClause optional ,
		unionIntersectExceptClause optional ,
		orderByClause optional ,
		limitClause optional ,
		offsetClause optional ,
		fetchClause optional ,
		forClause optional	