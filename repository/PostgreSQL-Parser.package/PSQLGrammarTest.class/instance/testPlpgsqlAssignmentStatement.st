tests-plpgsql
testPlpgsqlAssignmentStatement
	self
		parse: 'tax := subtotal * 0.06' rule: #plpgsqlAssignmentStatement;
		parse: 'my_record.user_id := 20' rule: #plpgsqlAssignmentStatement;
		parse: 'my_record.user_id = 20' rule: #plpgsqlAssignmentStatement;
		parse: '"matrix_a"["i"]["j"] := "battle_row"."count"' rule: #plpgsqlAssignmentStatement;
		parse: '"matrix_d"["i"]["j"] := (
          "defeat_strength"(
            "matrix_a"["i"]["j"],
            "matrix_a"["j"]["i"],
            "policy_row"."defeat_strength"
          ),
          "secondary_link_strength"(
            "i",
            "j",
            "policy_row"."tie_breaking"
          )
        )::"link_strength"' rule: #plpgsqlAssignmentStatement