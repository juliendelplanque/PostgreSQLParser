select command
fromItems1
	"[ ONLY ] table_name [ * ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]"
	^ only trim optional ,
			tableName trim , asterik trim optional ,
				(as trim optional , alias trim ,
					(openParenthesis trim ,
					(columnAlias separatedBy: comma trim),
					closeParenthesis trim) optional) optional