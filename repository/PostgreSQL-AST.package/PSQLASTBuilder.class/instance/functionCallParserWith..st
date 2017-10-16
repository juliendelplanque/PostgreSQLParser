expression
functionCallParserWith: expressionParser
	^ (super functionCallParserWith: expressionParser)
		==> [ :tokens |
			PSQLFunctionCall new
				functionIdentifier: tokens first;
				argumentsList: (tokens second second reject: [ :item | item = $, or: [ item first isArray ] ] thenCollect: #first);
				argumentsDictionary: (tokens second second reject: [ :item | item = $, or: [ item first isArray not ] ] thenCollect: [ :array | array first first -> array first third ]) asDictionary;
				yourself ]