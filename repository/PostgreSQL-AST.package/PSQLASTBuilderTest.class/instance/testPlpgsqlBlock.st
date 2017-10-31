tests-plpgsql
testPlpgsqlBlock
	| node |
	node := builder plpgsqlBlock parse: '<<label>>
DECLARE
	id ALIAS FOR $1;
	var INTEGER;
BEGIN
	var := id + 1;
END
label;'.
	
	self
		assert: node class equals: PSQLPlpgSQLASTBlock;
		assert: node declarations size equals: 2;
		assert: node statements size equals: 1;
		assert: node label class equals: PSQLPlpgSQLASTBlockLabel
		