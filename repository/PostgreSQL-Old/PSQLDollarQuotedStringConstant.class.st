"
I am a dollar quoted string constant.

e.g. '$tag$hello$tag$'
or: '$tag$hello$in$inner$in$$tag$'
"
Class {
	#name : #PSQLDollarQuotedStringConstant,
	#superclass : #PSQLStringConstant,
	#instVars : [
		'tag',
		'substrings'
	],
	#category : 'PostgreSQL-Old'
}

{ #category : #testing }
PSQLDollarQuotedStringConstant >> isDollarQuotedStringConstant [
]

{ #category : #accessing }
PSQLDollarQuotedStringConstant >> substrings [
	^ substrings
]

{ #category : #accessing }
PSQLDollarQuotedStringConstant >> substrings: anObject [
	substrings := anObject
]

{ #category : #accessing }
PSQLDollarQuotedStringConstant >> tag [
	^ tag
]

{ #category : #accessing }
PSQLDollarQuotedStringConstant >> tag: anObject [
	tag := anObject
]
