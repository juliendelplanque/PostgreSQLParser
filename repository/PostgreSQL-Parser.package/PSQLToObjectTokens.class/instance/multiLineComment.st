accessing
multiLineComment
	^ super multiLineComment ==> [ :items |
		|itemsToUse| 
		itemsToUse := items allButFirst allButLast flattened.
		PSQLMultilineComment new
			subcomments: (itemsToUse select: #isPSQLMultilineComment );
			contents: (String streamContents: [ :stream | 
				itemsToUse collect: [ :item |
					stream << (item isPSQLMultilineComment ifTrue: [ '/*',item contents,'*/' ] ifFalse: [ item ]) ] ]);
			yourself ]