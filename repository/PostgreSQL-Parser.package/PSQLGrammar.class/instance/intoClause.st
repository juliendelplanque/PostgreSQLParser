select command
intoClause
	"INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table"
	^ kw into trim , (kw temporary trim / kw temp trim / kw unlogged trim) optional , kw table trim optional , tableName trim