select command
intoClause
	"INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table"
	^ into trim , (temporary trim / temp trim / unlogged trim) optional , table trim optional , tableName