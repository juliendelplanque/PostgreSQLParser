accessing
metaCommand
	^ super metaCommand ==> [ :items |
		PSQLMetaCommand new
			contents: (String streamContents: [ :s | items flattened do: [ :item | s << item ] ]);
			yourself ]