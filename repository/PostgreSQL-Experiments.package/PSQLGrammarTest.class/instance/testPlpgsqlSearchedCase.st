tests-plpgsql
testPlpgsqlSearchedCase
	self
		parse: 'CASE
    WHEN x < 10 THEN
        msg := ''value is smaller than ten'';
    WHEN x < 20 THEN
        msg := ''value is smaller tham twenty'';
END CASE' rule: #plpgsqlSearchedCase;
		parse: 'CASE
    WHEN x < 10 THEN
        msg := ''value is smaller than ten'';
    ELSE
        msg := ''KO'';
END CASE' rule: #plpgsqlSearchedCase;
		parse: 'CASE
                     WHEN "matrix_f"["i"]["j"]
                     THEN ((-1::INT8) << 63, 0)::"link_strength"  
                     ELSE "matrix_d"["i"]["j"] END' rule: #plpgsqlSearchedCase