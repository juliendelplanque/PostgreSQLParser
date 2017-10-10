plpgsql
plpgsqlForLoop
	^ plpgsqlBeginLabel trim optional ,
	for trim , identifier trim , in trim , reverse trim optional , expression , '..' asParser trim , expression , (by trim , expression) trim optional , loop trim ,
		plpgsqlStatements ,
	endKeyword trim , loop trim , plpgsqlEndLabel trim optional