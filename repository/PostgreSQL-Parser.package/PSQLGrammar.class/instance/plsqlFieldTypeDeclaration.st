plpgsql
plsqlFieldTypeDeclaration
	^ identifier trim , tableName , $. asParser , columnName  , $% asParser , identifierOrKeyword