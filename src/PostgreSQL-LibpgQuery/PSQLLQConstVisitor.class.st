Class {
	#name : #PSQLLQConstVisitor,
	#superclass : #PSQLJSONVisitor,
	#category : #'PostgreSQL-LibpgQuery-Visitors'
}

{ #category : #visiting }
PSQLLQConstVisitor >> visitDictionary: aDictionary [
	self assert: (aDictionary keys includes: 'val').
	
	self halt: 'TODO'
]
