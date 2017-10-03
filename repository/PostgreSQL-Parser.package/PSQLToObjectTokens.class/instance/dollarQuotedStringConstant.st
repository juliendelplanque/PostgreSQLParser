accessing
dollarQuotedStringConstant
	^ super dollarQuotedStringConstant ==> [ :items |
		|openTag closeTag itemsToUse|
		openTag := String newFrom: (items flattened first).
		closeTag := String newFrom: (items flattened last).
		self assert: openTag = closeTag description: 'Otherwise the code is not valid.'.
		itemsToUse := items flattened allButFirst allButLast.
		PSQLDollarQuotedStringConstant new
			tag: openTag;
			substrings: (itemsToUse select: #isDollarQuotedStringConstant );
			contents: (String streamContents: [ :stream | 
				itemsToUse collect: [ :item |
					stream << (item isDollarQuotedStringConstant ifTrue: [ item tag ,item contents,item tag ] ifFalse: [ item class = PSQLPositionalParameter ifTrue: [ item contents ] ifFalse: [ item ] ]) ] ]);
			yourself ]