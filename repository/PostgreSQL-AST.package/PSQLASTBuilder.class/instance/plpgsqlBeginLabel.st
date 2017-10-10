accessing
plpgsqlBeginLabel
	^ super plpgsqlBeginLabel ==> [ :tokens | tokens second ]