"
I am a semicolon.

i.e. ';'
"
Class {
	#name : #PSQLSemicolon,
	#superclass : #PSQLSpecial,
	#category : 'PostgreSQL-Old'
}

{ #category : #accessing }
PSQLSemicolon >> contents [
	^ ';'
]

{ #category : #testing }
PSQLSemicolon >> isSemicolon [
	^ true
]
