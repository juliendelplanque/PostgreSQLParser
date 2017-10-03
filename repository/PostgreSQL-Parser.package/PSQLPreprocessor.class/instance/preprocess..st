pre-processing
preprocess: aString
	"Add a tag at the beginning of dollar quoted string's close tags."
	| readStream writeStream dollarTagStack |
	readStream := aString trim readStream.
	writeStream := WriteStream on: String new.
	dollarTagStack := Stack new.
	[ readStream atEnd ]
		whileFalse: [ 
			(readStream peek = $$)
				ifTrue: [ | currentTag |
					[currentTag := self parseDollarTag: readStream.
					(dollarTagStack isNotEmpty and: [dollarTagStack top = currentTag])
						ifTrue: [
							dollarTagStack pop.
							writeStream
								<< '$ ';
								<< currentTag;
								<< $$ ]
						ifFalse: [ 
							dollarTagStack push: currentTag.
							writeStream
								<< $$;
								<< currentTag;
								<< $$ ]] on: PSQLWasNotATag do: [ writeStream << readStream next ]  ]
				ifFalse: [ 
					writeStream << readStream next ] ].
	dollarTagStack ifNotEmpty: [ self error: 'Bad formatted PostgreSQL dump.' ].
	^ writeStream contents