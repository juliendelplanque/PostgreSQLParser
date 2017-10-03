pre-processing
parseDollarTag: aReadStream
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