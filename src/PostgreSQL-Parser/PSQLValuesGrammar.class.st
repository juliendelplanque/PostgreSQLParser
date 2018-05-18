"
I parse PostgreSQL VALUES command.
"
Class {
	#name : #PSQLValuesGrammar,
	#superclass : #PPCompositeParser,
	#traits : 'PSQLTExpressionDependingGrammar',
	#classTraits : 'PSQLTExpressionDependingGrammar classTrait',
	#instVars : [
		'expression',
		'valuesCommand',
		'kw',
		'openParenthesis',
		'comma',
		'closeParenthesis'
	],
	#category : #'PostgreSQL-Parser-Grammars-Others'
}

{ #category : #accessing }
PSQLValuesGrammar class >> dependencies [
	^ { self expressionParser . self tokenParser }
]

{ #category : #accessing }
PSQLValuesGrammar class >> ignoredNames [ 
	^ super ignoredNames , #(kw)
]

{ #category : #accessing }
PSQLValuesGrammar class >> tokenParser [
	^ PSQLTokenizer
]

{ #category : #dependencies }
PSQLValuesGrammar >> closeParenthesis [
	^ (self dependencyAt: self class tokenParser) closeParenthesis
]

{ #category : #dependencies }
PSQLValuesGrammar >> comma [
	^ (self dependencyAt: self class tokenParser) comma
]

{ #category : #dependencies }
PSQLValuesGrammar >> expression [
	^ (self expressionParser) expression
]

{ #category : #initialization }
PSQLValuesGrammar >> initialize [
	super initialize.
	kw := PSQLKeywordsParser new
]

{ #category : #dependencies }
PSQLValuesGrammar >> openParenthesis [
	^ (self dependencyAt: self class tokenParser) openParenthesis
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
