tests-plpgsql
testPlpgsqlBody
	self
		parse: 'BEGIN
IF TG_OP = ''INSERT'' THEN
  NEW.textvector = to_tsvector(NEW.old_text);
ELSIF NEW.old_text != OLD.old_text THEN
  NEW.textvector := to_tsvector(NEW.old_text);
END IF;
RETURN NEW;
END;' rule: #plpgsqlBody