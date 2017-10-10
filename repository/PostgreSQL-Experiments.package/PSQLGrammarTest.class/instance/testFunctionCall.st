tests
testFunctionCall
	self
		parse: 'fct()' rule: #expression;
		parse: 'sqrt(2)' rule: #expression;
		parse: 'fct(''test'')' rule: #expression;
		parse: 'fct(table)' rule: #expression;
		parse: 'fct(table.column)' rule: #expression;
		parse: 'fct(1,2)' rule: #expression;
		parse: 'fct(fct1(1,2), fct2(42))' rule: #expression;
		parse: 'fct(a := 1, b := hello)' rule: #expression;
		parse: '"defeat_strength"(
            "matrix_a"["i"]["j"],
            "matrix_a"["j"]["i"],
            "policy_row"."defeat_strength"
          )' rule: #expression