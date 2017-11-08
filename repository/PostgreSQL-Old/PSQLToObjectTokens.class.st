"
I take a pre-processed postgresql dump string and returns a list of tokens (subclasses of PSQLToken).
"
Class {
	#name : #PSQLToObjectTokens,
	#superclass : #PSQLTokenizer,
	#category : 'PostgreSQL-Old'
}

{ #category : #keywords }
PSQLToObjectTokens >> all [
	<psqlkeyword>
	^ self buildKeyword: 'all'
]

{ #category : #keywords }
PSQLToObjectTokens >> andKeyword [
	<psqlkeyword>
	^ self buildKeyword: 'and'
]

{ #category : #keywords }
PSQLToObjectTokens >> any [
	<psqlkeyword>
	^ self buildKeyword: 'any'
]

{ #category : #keywords }
PSQLToObjectTokens >> array [
	<psqlkeyword>
	^ self buildKeyword: 'array'
]

{ #category : #keywords }
PSQLToObjectTokens >> as [
	<psqlkeyword>
	^ self buildKeyword: 'as'
]

{ #category : #keywords }
PSQLToObjectTokens >> asc [
	<psqlkeyword>
	^ self buildKeyword: 'asc'
]

{ #category : #accessing }
PSQLToObjectTokens >> asterik [
	^ super asterik ==> [ :items | 
		PSQLAsterik new ]
]

{ #category : #keywords }
PSQLToObjectTokens >> begin [
	<psqlkeyword>
	^ self buildKeyword: 'begin'
]

{ #category : #keywords }
PSQLToObjectTokens >> between [
	<psqlkeyword>
	^ self buildKeyword: 'between'
]

{ #category : #accessing }
PSQLToObjectTokens >> binaryBitStringConstant [
	^ super binaryBitStringConstant ==> [ :items |
		PSQLBinaryBitStringConstant new
			contents: (String newFrom: items flattened);
			yourself ]
]

{ #category : #accessing }
PSQLToObjectTokens >> closeBracket [
	^ super closeBracket ==> [ :items |
		PSQLCloseBracket new ]
]

{ #category : #accessing }
PSQLToObjectTokens >> closeParenthesis [
	^ super closeParenthesis ==> [ :items |
		PSQLCloseParenthesis new ]
]

{ #category : #accessing }
PSQLToObjectTokens >> colon [
	^ super colon ==> [ :items |
		PSQLColon new ]
]

{ #category : #accessing }
PSQLToObjectTokens >> comma [
	^ super comma ==> [ :items |
		PSQLComma new ]
]

{ #category : #keywords }
PSQLToObjectTokens >> diagnostics [
	<psqlkeyword>
	^ self buildKeyword: 'diagnostics'
]

{ #category : #keywords }
PSQLToObjectTokens >> distinct [
	<psqlkeyword>
	^ self buildKeyword: 'distinct'
]

{ #category : #accessing }
PSQLToObjectTokens >> dollarQuotedStringConstant [
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
]

{ #category : #accessing }
PSQLToObjectTokens >> dollarQuotedStringConstantCloseTag [
	^ super dollarQuotedStringConstantCloseTag ==> [ :items |
		(items second ifNil: [ '' ]) asString ]
]

{ #category : #accessing }
PSQLToObjectTokens >> dollarQuotedStringConstantOpenTag [
	^ super dollarQuotedStringConstantOpenTag ==> [ :items | 
		(items second ifNil: [ '' ]) asString ]
]

{ #category : #keywords }
PSQLToObjectTokens >> else [
	<psqlkeyword>
	^ self buildKeyword: 'else'
]

{ #category : #keywords }
PSQLToObjectTokens >> elsif [
	<psqlkeyword>
	^ self buildKeyword: 'elsif'
]

{ #category : #keywords }
PSQLToObjectTokens >> endKeyword [
	<psqlkeyword>
	^ self buildKeyword: 'end'
]

{ #category : #keywords }
PSQLToObjectTokens >> except [
	<psqlkeyword>
	^ self buildKeyword: 'except'
]

{ #category : #keywords }
PSQLToObjectTokens >> exception [
	<psqlkeyword>
	^ self buildKeyword: 'exception'
]

{ #category : #keywords }
PSQLToObjectTokens >> execute [
	<psqlkeyword>
	^ self buildKeyword: 'execute'
]

{ #category : #keywords }
PSQLToObjectTokens >> exit [
	<psqlkeyword>
	^ self buildKeyword: 'exit'
]

{ #category : #keywords }
PSQLToObjectTokens >> foreach [
	<psqlkeyword>
	^ self buildKeyword: 'foreach'
]

{ #category : #keywords }
PSQLToObjectTokens >> from [
	<psqlkeyword>
	^ self buildKeyword: 'from'
]

{ #category : #keywords }
PSQLToObjectTokens >> full [
	<psqlkeyword>
	^ self buildKeyword: 'full'
]

{ #category : #keywords }
PSQLToObjectTokens >> get [
	<psqlkeyword>
	^ self buildKeyword: 'get'
]

{ #category : #keywords }
PSQLToObjectTokens >> group [
	<psqlkeyword>
	^ self buildKeyword: 'group'
]

{ #category : #accessing }
PSQLToObjectTokens >> hexBitStringConstant [
	^ super hexBitStringConstant ==> [ :items |
		PSQLHexBitStringConstant new
			contents: (String newFrom: items allButFirst allButLast flattened);
			yourself ]
]

{ #category : #accessing }
PSQLToObjectTokens >> identifierOrKeyword [
	| str |
	^ super identifierOrKeyword ==> [ :items |
		str := String newFrom: items.
		(PSQLKeyword isKeyword: str)
			ifTrue: [ PSQLKeyword new contents: str; yourself ]
			ifFalse: [ PSQLIdentifier new contents: str; yourself ]  ]
]

{ #category : #accessing }
PSQLToObjectTokens >> metaCommand [
	^ super metaCommand ==> [ :items |
		PSQLMetaCommand new
			contents: (String streamContents: [ :s | items flattened do: [ :item | s << item ] ]);
			yourself ]
]

{ #category : #accessing }
PSQLToObjectTokens >> multiLineComment [
	^ super multiLineComment ==> [ :items |
		|itemsToUse| 
		itemsToUse := items allButFirst allButLast flattened.
		PSQLMultilineComment new
			subcomments: (itemsToUse select: #isPSQLMultilineComment );
			contents: (String streamContents: [ :stream | 
				itemsToUse collect: [ :item |
					stream << (item isPSQLMultilineComment ifTrue: [ '/*',item contents,'*/' ] ifFalse: [ item ]) ] ]);
			yourself ]
]

{ #category : #keywords }
PSQLToObjectTokens >> null [
	<psqlkeyword>
	^ self buildKeyword: 'null'
]

{ #category : #keywords }
PSQLToObjectTokens >> nulls [
	<psqlkeyword>
	^ self buildKeyword: 'nulls'
]

{ #category : #accessing }
PSQLToObjectTokens >> numericConstant [
	^ super numericConstant ==> [ :items |
		PSQLNumericConstant new
			contents: (String newFrom: (items flattened reject: #isNil));
			yourself ]
]

{ #category : #keywords }
PSQLToObjectTokens >> of [
	<psqlkeyword>
	^ self buildKeyword: 'of'
]

{ #category : #keywords }
PSQLToObjectTokens >> offset [
	<psqlkeyword>
	^ self buildKeyword: 'offset'
]

{ #category : #keywords }
PSQLToObjectTokens >> on [
	<psqlkeyword>
	^ self buildKeyword: 'on'
]

{ #category : #accessing }
PSQLToObjectTokens >> oneLineComment [
	^ super oneLineComment ==> [ :items | 
		PSQLOneLineComment new
			contents: (String newFrom: items allButFirst flattened);
			yourself ]
]

{ #category : #keywords }
PSQLToObjectTokens >> only [
	<psqlkeyword>
	^ self buildKeyword: 'only'
]

{ #category : #accessing }
PSQLToObjectTokens >> openBracket [
	^ super openBracket ==> [ :items |
		PSQLOpenBracket new ]
]

{ #category : #accessing }
PSQLToObjectTokens >> openParenthesis [
	^ super openParenthesis ==> [ :items |
		PSQLOpenParenthesis new ]
]

{ #category : #accessing }
PSQLToObjectTokens >> operator [
	^ super operator ==> [ :items |
		PSQLOperator new
			contents: (String newFrom: items flattened);
			yourself ]
]

{ #category : #keywords }
PSQLToObjectTokens >> or [
	<psqlkeyword>
	^ self buildKeyword: 'or'
]

{ #category : #keywords }
PSQLToObjectTokens >> order [
	<psqlkeyword>
	^ self buildKeyword: 'order'
]

{ #category : #keywords }
PSQLToObjectTokens >> outer [
	<psqlkeyword>
	^ self buildKeyword: 'outer'
]

{ #category : #keywords }
PSQLToObjectTokens >> perform [
	<psqlkeyword>
	^ self buildKeyword: 'perform'
]

{ #category : #accessing }
PSQLToObjectTokens >> period [
	^ super period ==> [ :items |
		PSQLPeriod new ]
]

{ #category : #accessing }
PSQLToObjectTokens >> positionalParameter [
	^ super positionalParameter ==> [ :items |
		PSQLPositionalParameter new
			contents: (String newFrom: items flattened);
			yourself ]
]

{ #category : #keywords }
PSQLToObjectTokens >> query [
	<psqlkeyword>
	^ self buildKeyword: 'query'
]

{ #category : #accessing }
PSQLToObjectTokens >> quotedIdentifier [
	^ super quotedIdentifier ==> [ :items | String newFrom: items allButFirst allButLast flattened ]
]

{ #category : #keywords }
PSQLToObjectTokens >> raise [
	<psqlkeyword>
	^ self buildKeyword: 'raise'
]

{ #category : #keywords }
PSQLToObjectTokens >> record [
	<psqlkeyword>
	^ self buildKeyword: 'record'
]

{ #category : #keywords }
PSQLToObjectTokens >> recursive [
	<psqlkeyword>
	^ self buildKeyword: 'recursive'
]

{ #category : #keywords }
PSQLToObjectTokens >> replace [
	<psqlkeyword>
	^ self buildKeyword: 'replace'
]

{ #category : #keywords }
PSQLToObjectTokens >> return [
	<psqlkeyword>
	^ self buildKeyword: 'return'
]

{ #category : #keywords }
PSQLToObjectTokens >> reverse [
	<psqlkeyword>
	^ self buildKeyword: 'reverse'
]

{ #category : #keywords }
PSQLToObjectTokens >> right [
	<psqlkeyword>
	^ self buildKeyword: 'right'
]

{ #category : #keywords }
PSQLToObjectTokens >> row [
	<psqlkeyword>
	^ self buildKeyword: 'row'
]

{ #category : #keywords }
PSQLToObjectTokens >> rows [
	<psqlkeyword>
	^ self buildKeyword: 'rows'
]

{ #category : #keywords }
PSQLToObjectTokens >> select [
	<psqlkeyword>
	^ self buildKeyword: 'select'
]

{ #category : #accessing }
PSQLToObjectTokens >> semicolon [
	^ super semicolon ==> [ :items |
		PSQLSemicolon new ]
]

{ #category : #keywords }
PSQLToObjectTokens >> share [
	<psqlkeyword>
	^ self buildKeyword: 'share'
]

{ #category : #accessing }
PSQLToObjectTokens >> simpleStringConstant [
	^ super simpleStringConstant ==> [ :items |
		PSQLSimpleStringConstant new
			contents: (String newFrom: items allButFirst allButLast flattened);
			yourself ]
]

{ #category : #keywords }
PSQLToObjectTokens >> slice [
	<psqlkeyword>
	^ self buildKeyword: 'slice'
]

{ #category : #accessing }
PSQLToObjectTokens >> start [
	^ super start ==> [ :items | items flattened ]
]

{ #category : #keywords }
PSQLToObjectTokens >> strict [
	<psqlkeyword>
	^ self buildKeyword: 'strict'
]

{ #category : #accessing }
PSQLToObjectTokens >> stringConstantWithUnicodeEscape [
	^ super stringConstantWithUnicodeEscape ==> [ :items |
		PSQLStringConstantWithUnicodeEscape new
			contents: (String newFrom: items allButFirst allButLast flattened);
			yourself ]
]

{ #category : #keywords }
PSQLToObjectTokens >> symmetric [
	<psqlkeyword>
	^ self buildKeyword: 'symmetric'
]

{ #category : #accessing }
PSQLToObjectTokens >> unquotedIdentifierOrKeyword [
	^ super unquotedIdentifierOrKeyword ==> [ :items | (String newFrom: items flattened) asLowercase ]
]

{ #category : #accessing }
PSQLToObjectTokens >> whiteSpace [
	^ super whiteSpace ==> [ :char | PSQLWhiteSpace new contents: char asString ]
]
