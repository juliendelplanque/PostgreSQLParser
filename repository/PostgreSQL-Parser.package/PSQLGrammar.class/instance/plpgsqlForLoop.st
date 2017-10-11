plpgsql
plpgsqlForLoop
	^ plpgsqlBeginLabel trim optional ,
	kw for trim , identifier trim , kw in trim , kw reverse trim optional , expression , '..' asParser trim , expression , (kw by trim , expression) trim optional , kw loop trim ,
		plpgsqlStatements ,
	kw endKeyword trim , kw loop trim , plpgsqlEndLabel trim optional