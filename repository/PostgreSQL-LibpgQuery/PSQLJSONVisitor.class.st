"
I am an abstract visitor for object extracted from a JSON formatted String.

Used as it, this visitor simply does a shallow copy of the objects.
"
Class {
	#name : #PSQLJSONVisitor,
	#superclass : #Object,
	#category : #PostgreSQL-LibpgQuery-Visitors
}

{ #category : #visiting }
PSQLJSONVisitor >> visitArray: anArray [
	^ anArray collect: [ :items | items psqlJSONAccept: self ]
]

{ #category : #visiting }
PSQLJSONVisitor >> visitBoolean: aBoolean [
	^ aBoolean
]

{ #category : #visiting }
PSQLJSONVisitor >> visitDictionary: aDictionary [
	| newDict |
	newDict := Dictionary new.
	aDictionary associations do: [ :association |
		newDict at: association head put: (association tail psqlJSONAccept: self) ].
	^ newDict
]

{ #category : #visiting }
PSQLJSONVisitor >> visitNil: anUndefinedObject [
	^ anUndefinedObject
]

{ #category : #visiting }
PSQLJSONVisitor >> visitNumber: aNumber [
	^ aNumber
]

{ #category : #visiting }
PSQLJSONVisitor >> visitString: aString [
	^ aString
]

{ #category : #visiting }
PSQLJSONVisitor >> visitUndefinedObject: anUndefinedObject [
	^ anUndefinedObject
]
