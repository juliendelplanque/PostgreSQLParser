insert command
insertCommand
	"[ WITH [ RECURSIVE ] with_query [, ...] ]
INSERT INTO table_name [ AS alias ] [ ( column_name [, ...] ) ]
    { DEFAULT VALUES | VALUES ( { expression | DEFAULT } [, ...] ) [, ...] | query }
    [ ON CONFLICT [ conflict_target ] conflict_action ]
    [ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]"
	
	^ withClause trim optional ,
		kw insert trim , kw into trim , tableName trim , (kw as trim , alias) optional , 
		(openParenthesis trim , 
			(expression plus separatedBy: comma trim) , "Apparently, a column name can be generated from an expression."
		closeParenthesis trim) trim optional ,
		valuesClause trim ,
		onConflictClause trim optional ,
		returningClause trim optional