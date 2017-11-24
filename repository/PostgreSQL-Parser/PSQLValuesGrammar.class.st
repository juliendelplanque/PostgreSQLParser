"
I parse PostgreSQL VALUES command.
"
Class {
	#name : #PSQLValuesGrammar,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'expression',
		'valuesCommand'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLValuesGrammar class >> dependencies [
	^ { PSQLGrammar }
]

{ #category : #dependencies }
PSQLValuesGrammar >> expression [
	^ (self dependencyAt: PSQLGrammar) expression
]

{ #category : #accessing }
PSQLValuesGrammar >> start [
	^ valuesCommand end
]

{ #category : #'values command' }
PSQLValuesGrammar >> valuesCommand [
	"This should implement:
		VALUES ( expression [, ...] ) [, ...]
	But it implements:
		VALUES ( { expression | DEFAULT } [, ...] ) [, ...]
	instead in order to be reusable in #insertCommand.
	
	Please manage this fact while building the AST."
	
	^ kw values trim ,
	((openParenthesis trim,
		((kw default / expression) plus separatedBy: comma trim) ,
	closeParenthesis trim) plus separatedBy: comma trim)
]
