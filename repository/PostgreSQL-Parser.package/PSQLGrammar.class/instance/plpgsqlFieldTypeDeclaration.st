plpgsql
plpgsqlFieldTypeDeclaration
	^ identifier trim , tableName , $. asParser , columnName  , $% asParser , identifierOrKeyword