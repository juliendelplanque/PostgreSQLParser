"
I am an abstract visitor for object extracted from a JSON formatted String.

Used as it, this visitor simply does a shallow copy of the objects.
"
Class {
	#name : #PSQLJSONVisitor,
	#superclass : #Object,
	#category : #'PostgreSQL-LibpgQuery-Visitors'
}

{ #category : #helpers }
PSQLJSONVisitor >> convertToIdentifierOrAttributeAccess: anArrayOfStrings [
	"Converts #anArrayOfStrings to either an PSQLASTIdentifier if the size of #anArrayOfStrings is 1 or
	a PSQLASTAttributeAccess if the size of #anArrayOfStrings is greater than 1."
	| target |
	anArrayOfStrings size = 1
		ifTrue: [ 
			^ PSQLASTIdentifier new
				identifier: anArrayOfStrings first;
				yourself ].
	
	target := PSQLASTIdentifier new
					identifier: anArrayOfStrings first;
					yourself.
	
	 anArrayOfStrings allButFirst do: [ :string |
			target := PSQLASTAttributeAccess new
							accessed: target;
							attributeIdentifier: (PSQLASTIdentifier new
														identifier: string;
														yourself);
							yourself ].
	^ target
]

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
		newDict at: association key put: (association value psqlJSONAccept: self) ].
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
