tests-accessing
testPlpgsqlArrayLoop
	| node |
	node := builder plpgsqlArrayLoop parse: 'FOREACH x IN ARRAY $1
  LOOP
    s := s + x;
    t := s;
  END LOOP'.
	self
		assert: node class equals: PSQLPlpgSQLASTArrayLoop;
		assert: node beginLabel isNil;
		assert: node endLabel isNil;
		assert: node statements size equals: 2;
		assert: node target class equals: PSQLASTIdentifier;
		assert: node arrayExpression class equals: PSQLPlpgSQLASTPositionalParameter;
		assert: node sliceNumber isNil