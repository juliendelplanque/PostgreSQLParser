plpgsql
plpgsqlStatements
	^ plpgsqlStatement trim , (semicolon trim , endKeyword not , plpgsqlStatement) trim star , semicolon trim optional