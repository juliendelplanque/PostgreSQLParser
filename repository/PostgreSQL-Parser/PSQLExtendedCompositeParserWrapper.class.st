"
I am a composite parser wrapper that allows to extend a PPComposite parser easily.
"
Class {
	#name : #PSQLExtendedCompositeParserWrapper,
	#superclass : #Object,
	#instVars : [
		'extendedCompositeParser'
	],
	#category : #PostgreSQL-Parser-Others
}

{ #category : #'reflective operations' }
PSQLExtendedCompositeParserWrapper >> doesNotUnderstand: aMessage [

	^ [extendedCompositeParser rule: aMessage selector]
		 on: KeyNotFound
		 do: [ PPFailure message: ('Unknown rule in ExtendedCompositeParser : ' , aMessage selector asString) ]
]

{ #category : #accessing }
PSQLExtendedCompositeParserWrapper >> extendedCompositeParser: anObject [
	extendedCompositeParser := anObject
]
