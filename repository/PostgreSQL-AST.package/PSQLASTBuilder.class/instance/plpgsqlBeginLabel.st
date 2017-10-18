plpgsql
plpgsqlBeginLabel
	^ super plpgsqlBeginLabel ==> [ :tokens | tokens second ]