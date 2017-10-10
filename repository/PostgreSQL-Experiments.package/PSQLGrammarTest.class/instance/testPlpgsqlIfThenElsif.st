tests-plpgsql
testPlpgsqlIfThenElsif
	self
		parse: 'IF number = 0 THEN
    result := ''zero'';
ELSIF number > 0 THEN
    result := ''positive'';
ELSIF number < 0 THEN
    result := ''negative'';
ELSE
    result := ''NULL'';
END IF' rule: #plpgsqlIfThenElsif