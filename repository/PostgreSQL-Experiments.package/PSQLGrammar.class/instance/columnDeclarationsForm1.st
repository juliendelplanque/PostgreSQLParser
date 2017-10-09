create table command
columnDeclarationsForm1
	"{ column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
    | table_constraint
    | LIKE parent_table [ like_option ... ] }
    [, ... ]"
	^ columnName trim , dataType