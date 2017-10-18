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
END IF' rule: #plpgsqlIfThenElsif;
	parse: 'IF TG_OP = ''INSERT'' THEN
  NEW.textvector = to_tsvector(NEW.old_text);
ELSIF NEW.old_text != OLD.old_text THEN
  NEW.textvector := to_tsvector(NEW.old_text);
END IF' rule: #plpgsqlIfThenElsif;
	parse: 'IF x = 1 THEN
	stmt := 1;
ELSE IF x = 2 THEN
	stmt := 2;
ELSIF x = 3 THEN
	stmt := 3;
ELSE
	stmt := stmt +1;
END IF' rule: #plpgsqlIfThenElsif