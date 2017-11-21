"
I visit the JSON model to build PSQLASTLQComments.
"
Class {
	#name : #PSQLLQCommentVisitor,
	#superclass : #PSQLJSONVisitor,
	#category : #PostgreSQL-LibpgQuery-Visitors
}

{ #category : #ensuring }
PSQLLQCommentVisitor >> ensureObjnameIsArrayOfStrings: aDictionary [
	"I ensure that the value at the key 'objname' of aDictionary is an array of strings so latter processing can be done without worrying about it."
	
	self assert: (aDictionary at: 'objname') isArray.
	aDictionary at: 'objname' put: ((aDictionary at: 'objname') collect: [ :item | item psqlJSONAccept: PSQLObjnameExtractor new ]).
	
	((aDictionary at: 'objname') allSatisfy: [ :item | item isArray and: [ item size = 1 and: [ item first isString ] ] ])
		ifTrue: [ aDictionary at: 'objname' put: ((aDictionary at: 'objname') collect: #first) ].
	
	(aDictionary at: 'objname') do: [ :item | self assert: item isString ].
]

{ #category : #visiting }
PSQLLQCommentVisitor >> visitDictionary: aDictionary [

	self assert: (aDictionary at: 'comment') isString.
	self ensureObjnameIsArrayOfStrings: aDictionary.
	
	^ PSQLASTLQComment new
		comment: (aDictionary at: 'comment');
		target: (self convertToIdentifierOrAttributeAccess:  (aDictionary at: 'objname'));
		yourself
]
