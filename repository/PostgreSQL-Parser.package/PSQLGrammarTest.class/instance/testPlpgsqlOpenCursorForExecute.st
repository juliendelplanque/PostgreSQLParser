tests-plpgsql
testPlpgsqlOpenCursorForExecute
	self
		parse: 'OPEN curs1 FOR EXECUTE format(''SELECT * FROM %I WHERE col1 = $1'',tabname) USING keyvalue' rule: #plpgsqlOpenCursorForExecute