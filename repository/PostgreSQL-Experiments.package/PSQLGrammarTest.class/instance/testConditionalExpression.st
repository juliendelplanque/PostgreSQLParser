tests-expression
testConditionalExpression
	self parse: 'CASE WHEN (actualite.debut IS NULL) THEN actualite.debutpublication ELSE actualite.debut END' rule: #conditionalExpression;
	parse: 'CASE WHEN 1 = 1 THEN ''Ok'' ELSE CASE WHEN 1 = 2 THEN ''Ooops''::text END END' rule: #conditionalExpression