expression
conditionalExpression
	^ super conditionalExpression ==> [ :tokens |
		PSQLConditionalExpression new
			conditionsToExpressions: (tokens second collect: [ :item | item second -> item fourth ]);
			elseExpression: tokens third second;
			yourself ]