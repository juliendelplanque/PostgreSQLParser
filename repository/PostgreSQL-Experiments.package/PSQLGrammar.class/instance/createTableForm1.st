create table command
createTableForm1
	"CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name ( [
  { column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
    | table_constraint
    | LIKE parent_table [ like_option ... ] }
    [, ... ]
] )
[ INHERITS ( parent_table [, ... ] ) ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITH OIDS | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace ]"
	^ create , 
	((global / local) trim optional , ((temporary / temp) trim / unlogged trim)) optional ,
	table trim ,
	(if trim , notKeyword trim , exists trim) ,
	identifier trim ,
	openParenthesis trim ,
		columnDeclarationsForm1 trim ,
	closeParenthesis trim ,
	createTableWithClauseInheritsClause trim optional ,
	createTableWithClause trim optional ,
	createTableOnCommitClause trim optional ,
	createTableTableSpaceClause trim optional