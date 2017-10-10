tests-plpgsql
testPlpgsqlExecuteStatement
	self
		parse: 'EXECUTE ''SELECT count(*) FROM mytable WHERE inserted_by = $1 AND inserted <= $2''
   INTO c
   USING checked_user, checked_date' rule: #plpgsqlExecuteStatement;
	parse: 'EXECUTE ''SELECT count(*) FROM ''
    || quote_ident(tabname)
    || '' WHERE inserted_by = $1 AND inserted <= $2''
   INTO c
   USING checked_user, checked_date' rule: #plpgsqlExecuteStatement;
	parse: 'EXECUTE format(''SELECT count(*) FROM %I WHERE inserted_by = $1 AND inserted <= $2'', tabname)
   INTO c
   USING checked_user, checked_date' rule: #plpgsqlExecuteStatement