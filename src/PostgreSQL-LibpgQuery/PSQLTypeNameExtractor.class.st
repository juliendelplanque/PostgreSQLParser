"
Deals with 'TypeName' key of the dictionary. Replace it by an array containing the name of the object and eventual attribute accesses.
"
Class {
	#name : #PSQLTypeNameExtractor,
	#superclass : #PSQLJSONVisitor,
	#category : #PostgreSQL-LibpgQuery-Visitors
}

{ #category : #visiting }
PSQLTypeNameExtractor >> visitArray: anArray [
	| result |
	result := (super visitArray: anArray) flattened.
	
	result do: [ :item | self assert: item isString ].
	
	^ self convertToIdentifierOrAttributeAccess: result
]

{ #category : #visiting }
PSQLTypeNameExtractor >> visitDictionary: aDictionary [
	| value |
	(aDictionary size = 1 and: [ aDictionary keys includes: 'TypeName' ])
		ifFalse: [ ^ self error ].
	
	value := aDictionary at: 'TypeName'.
	
	self assert: value isDictionary.
	
	^ (value at: 'names') psqlJSONAccept: self
]
