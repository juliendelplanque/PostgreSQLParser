"
With dollar-quoted string it is hard to find out how strings are nested because open tag and close tag are the same.
e.g. '$function$ body $inner$in$inner$$function$'

Space are not allowed in tag name according to PostgreSQL spec, therefore, a space is used to be able to recognize close tags.
e.g. '$function$ body $inner$in$ inner$$ function$'
"
Class {
	#name : #PSQLPreprocessor,
	#superclass : #Object,
	#category : #PostgreSQL-Parser-Core
}

{ #category : #pre-processing }
PSQLPreprocessor >> parseDollarTag: aReadStream [
	| shift |
	aReadStream next = $$ ifFalse: [ self error: 'Bad formatted PostgreSQL dump.' ].
	shift := 1.
	^ String streamContents: [ :s |
		[aReadStream peek = $$ or: [ aReadStream peek = Character space ]]
			whileFalse: [ 
				aReadStream atEnd
					ifTrue: [ self error: 'Bad formatted PostgreSQL dump.' ].
				s << aReadStream next.
				shift := shift + 1 ].
		aReadStream peek = Character space
			ifTrue: [ 
				shift timesRepeat: [ aReadStream back ].
				PSQLWasNotATag signal ].
		aReadStream next = $$ ifFalse: [ self error: 'Bad formatted PostgreSQL dump.' ] ]
]

{ #category : #pre-processing }
PSQLPreprocessor >> preprocess: aString [
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
]
