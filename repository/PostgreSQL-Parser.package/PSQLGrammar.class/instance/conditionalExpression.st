expression
conditionalExpression
	^ kw case trim ,
		(kw when trim , expression trim , kw then trim , expression trim) plus,
		(kw else trim , expression trim) optional ,
	kw endKeyword trim