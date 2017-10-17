tests-expression
testConditionalExpression
	| node |
	node := builder expression parse: 'CASE WHEN (actualite.debut IS NULL) THEN actualite.debutpublication ELSE actualite.debut END'.
	self
		assert: node class equals: PSQLConditionalExpression;
		assert: node conditionsToExpressions size equals: 1;
		assert: node conditionsToExpressions first head class equals: PSQLParenthesedExpression;
		assert: node conditionsToExpressions first tail class equals: PSQLASTAttributeAccess;
		assert: node elseExpression class equals: PSQLASTAttributeAccess