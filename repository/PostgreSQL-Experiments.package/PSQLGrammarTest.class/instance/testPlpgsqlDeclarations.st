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
arow RECORD;' rule: #plpgsqlDeclarations;
		parse: '"issue_row"       "issue"%ROWTYPE;
      "policy_row"      "policy"%ROWTYPE;
      "dimension_v"     INT4;
      "matrix_a"        INT4[][];
      "matrix_d"        "link_strength"[][];
      "matrix_p"        "link_strength"[][];
      "matrix_t"        "link_strength"[][];
      "matrix_f"        BOOLEAN[][];
      "matrix_b"        BOOLEAN[][];
      "i"               INT4;
      "j"               INT4;
      "m"               INT4;
      "n"               INT4;
      "battle_row"      "battle"%ROWTYPE;
      "rank_ary"        INT4[];
      "rank_v"          INT4;
      "initiative_id_v" "initiative"."id"%TYPE;' rule: #plpgsqlDeclarations