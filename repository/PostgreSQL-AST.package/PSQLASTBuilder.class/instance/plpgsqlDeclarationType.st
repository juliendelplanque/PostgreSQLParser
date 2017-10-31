plpgsql
plpgsqlDeclarationType
	^ super plpgsqlDeclarationType ==> [ :tokens |
		|node|
		node := PSQLPlpgSQLASTType new
					identifier: (PSQLASTIdentifier new
										identifier: (tokens sixth joinUsing: ' ');
										yourself);
					yourself.
		tokens seventh ifNotNil: [
			tokens seventh first = $(
				ifTrue: [ node size: tokens sixth second ]
				ifFalse: [ node dimensions: tokens sixth size ] ].
		node ]