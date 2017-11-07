insert command
conflictTarget1
	"( { index_column_name | ( index_expression ) } [ COLLATE collation ] [ opclass ] [, ...] ) [ WHERE index_predicate ]"
	self flag: 'TODO'.
	^ openParenthesis trim ,
	(columnName / ( openParenthesis trim , expression trim , closeParenthesis )) ,
	nil asParser