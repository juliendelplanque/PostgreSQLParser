"
I visit the JSON model to build PSQLASTLQComments.
"
Class {
	#name : #PSQLLQCommentVisitor,
	#superclass : #PSQLJSONVisitor,
	#category : #PostgreSQL-LibpgQuery-Visitors
}

{ #category : #visiting }
PSQLLQCommentVisitor >> visitDictionary: aDictionary [
	| target |
	self assert: (aDictionary at: 'comment') isString.
	"self ensureObjnameIsArrayOfStrings: aDictionary."
	self assert: (aDictionary at: 'objname') isArray.
	
	target := (aDictionary at: 'objname') size = 1
					ifTrue: [ (aDictionary at: 'objname') first psqlJSONAccept: PSQLTypeNameExtractor new ]
					ifFalse: [ (aDictionary at: 'objname') psqlJSONAccept: PSQLTypeNameExtractor new ].
	^ PSQLASTLQComment new
		comment: (aDictionary at: 'comment');
		target: target;
		yourself
]