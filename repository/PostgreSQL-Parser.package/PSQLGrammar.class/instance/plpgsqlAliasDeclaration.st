plpgsql
plpgsqlAliasDeclaration
	^ identifier trim , alias trim , kw for trim , (($$ asParser , numericConstant) trim / identifier trim)