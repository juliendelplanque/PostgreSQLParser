tests-plpgsql
testPlpgsqlReturn
	self
		parse: 'RETURN 1 + 2' rule: #plpgsqlReturn;
		parse: 'RETURN scalar_var' rule: #plpgsqlReturn;
		parse: 'RETURN composite_type_var' rule: #plpgsqlReturn;
		parse: 'RETURN NEXT r' rule: #plpgsqlReturn;
		parse: 'RETURN' rule: #plpgsqlReturn;
		parse: 'RETURN QUERY SELECT flightid
                   FROM flight
                  WHERE flightdate >= $1
                    AND flightdate < ($1 + 1)' rule: #plpgsqlReturn;
		parse: 'RETURN QUERY EXECUTE ''SELECT flightid
                   FROM flight
                  WHERE flightdate >= $1
                    AND flightdate < ($1 + 1)''' rule: #plpgsqlReturn;
		parse: 'RETURN (1, 2, ''three''::text)' rule: #plpgsqlReturn