plpgsql
plpgsqlStatements
	^ plpgsqlStatement trim , (semicolon trim , kw endKeyword not , plpgsqlStatement) trim star , semicolon trim optional