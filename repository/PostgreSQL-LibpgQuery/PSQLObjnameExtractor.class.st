"
Deals with objname key of the dictionary. Replace it by an array containing the name of the object and eventual attribute accesses.
"
Class {
	#name : #PSQLObjnameExtractor,
	#superclass : #PSQLJSONVisitor,
	#category : #PostgreSQL-LibpgQuery-Visitors
}

{ #category : #visiting }
PSQLObjnameExtractor >> visitDictionary: aDictionary [
	| value |
	(aDictionary size = 1 and: [ aDictionary keys includes: 'TypeName' ])
		ifFalse: [ ^ super visitDictionary: aDictionary ].
		
	value := aDictionary at: 'TypeName'.
	
	value isDictionary
		ifTrue: [ ^  value at: 'names' ].
		
	self error: 'Something is wrong with the visitor.'
]
