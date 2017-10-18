tests-accessing
testPlpgsqlSimpleCase
	| node |
	node := builder plpgsqlSimpleCase parse: 'CASE
    WHEN x < 10 THEN
        msg := ''value is smaller than ten'';
    ELSE
        msg := ''KO'';
END CASE'.
	self
		assert: node class equals: PSQLPlpgSQLASTSimpleCase;
		assert: node conditionToStatements size equals: 1;
		assert: node elseStatements size equals: 1