tests-plpgsql
testPlpgsqlAliasDeclaration
	self
		parse: 'subtotal ALIAS FOR $1' rule: #plpgsqlAliasDeclaration;
		parse: 'v_string ALIAS FOR $1' rule: #plpgsqlAliasDeclaration;
		parse: 'index ALIAS FOR $2' rule: #plpgsqlAliasDeclaration;
		parse: 'prior ALIAS FOR old' rule: #plpgsqlAliasDeclaration;
		parse: 'updated ALIAS FOR new' rule: #plpgsqlAliasDeclaration