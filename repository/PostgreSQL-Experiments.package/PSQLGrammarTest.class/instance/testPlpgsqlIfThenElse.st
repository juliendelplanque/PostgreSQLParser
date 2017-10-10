tests-plpgsql
testPlpgsqlIfThenElse
	self
		parse: 'IF parentid = 1 OR parentid = ''''
THEN
    RETURN fullname;
ELSE
    RETURN hp_true_filename(parentid) || ''/'' || fullname;
END IF' rule: #plpgsqlIfThenElse;
		parse: 'IF v_count > 0 THEN
    RETURN ''t'';
ELSE
    RETURN ''f'';
END IF' rule: #plpgsqlIfThenElse;
		parse: 'IF demo_row.sex = ''m'' THEN
    pretty_sex := ''man'';
ELSE
    IF demo_row.sex = ''f'' THEN
        pretty_sex := ''woman'';
    END IF;
END IF' rule: #plpgsqlIfThenElse