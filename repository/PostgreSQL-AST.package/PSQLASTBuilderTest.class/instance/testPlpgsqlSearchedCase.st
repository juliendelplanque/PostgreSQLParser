tests-accessing
testPlpgsqlSearchedCase
	| node |
	node := builder plpgsqlSearchedCase parse: 'CASE x
    WHEN 1, 2 THEN
        msg := ''one or two'';
	WHEN 3, 4 THEN
        msg := ''three or four'';
END CASE'.
	self
		assert: node class equals: PSQLPlpgSQLASTSearchedCase;
		assert: node searchedExpression class equals: PSQLASTIdentifier;
		assert: node conditionsToStatements size equals: 2;
		assert: node conditionsToStatements first head size equals: 2;
		assert: node conditionsToStatements first tail size equals: 1;
		assert: node conditionsToStatements second head size equals: 2;
		assert: node conditionsToStatements second tail size equals: 1;
		assert: node elseStatements isNil