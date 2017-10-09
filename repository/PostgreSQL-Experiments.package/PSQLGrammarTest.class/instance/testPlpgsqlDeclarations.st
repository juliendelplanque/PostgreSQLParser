tests-plpgsql
testPlpgsqlDeclarations
	self
		parse: 'local_a text := a;
    local_b text := b;' rule: #plpgsqlDeclarations;
		parse: 'prior ALIAS FOR old;
  updated ALIAS FOR new;' rule: #plpgsqlDeclarations;
		parse: 'user_id integer;
quantity numeric(5);
url varchar;
myrow tablename%ROWTYPE;
myfield tablename.columnname%TYPE;
arow RECORD;' rule: #plpgsqlDeclarations