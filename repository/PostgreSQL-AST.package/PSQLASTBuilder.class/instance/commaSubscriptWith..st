expression
commaSubscriptWith: expressionParser
	^ (super commaSubscriptWith: expressionParser) ==> [ :tokens |
		PSQLASTArrayConstructor new
			items: ((tokens copyFrom: 2 to: tokens size - 1) first reject: [ :object | object = $, ] thenCollect: #first);
			yourself ]