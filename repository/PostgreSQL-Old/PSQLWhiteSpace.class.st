"
I am a whitespace as defined by PostgreSQL.

i.e. tab, space, newline
"
Class {
	#name : #PSQLWhiteSpace,
	#superclass : #PSQLToken,
	#category : 'PostgreSQL-Old'
}

{ #category : #testing }
PSQLWhiteSpace >> isWhiteSpace [
	^ true
]
