tests-expression
testConditionalExpression
	self parse: 'CASE WHEN (actualite.debut IS NULL) THEN actualite.debutpublication ELSE actualite.debut END' rule: #conditionalExpression