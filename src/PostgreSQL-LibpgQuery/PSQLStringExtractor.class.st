"
I extract strings stored in dictionary like
{
	'key' -> {
		'String' -> {
			'str' -> 'a string'
		} asDictionary
	} asDictionary
} asDictionary

to simplify them to:

{
	'key' -> 'a string'
} asDictionary
"
Class {
	#name : #PSQLStringExtractor,
	#superclass : #PSQLJSONVisitor,
	#category : #'PostgreSQL-LibpgQuery-Visitors'
}

{ #category : #visiting }
PSQLStringExtractor >> visitDictionary: aDictionary [
	| value |
	(aDictionary keys size = 1 and: [ aDictionary keys includes: 'String' ])
		ifFalse: [ ^ super visitDictionary: aDictionary ].
		
	value := aDictionary at: 'String'.
	^ value isString 
		ifTrue: [ value ]
		ifFalse: [ value at: 'str' ]
]
