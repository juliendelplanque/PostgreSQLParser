Class {
	#name : #PSQLValuesGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #'PostgreSQL-Parser-Tests'
}

{ #category : #accessing }
PSQLValuesGrammarTest >> parserClass [
	^ PSQLValuesGrammar
]

{ #category : #'tests-values command' }
PSQLValuesGrammarTest >> testValuesCommand [
	self
		parse: 'VALUES (1, ''one''), (2, ''two''), (3, ''three'')' rule: #valuesCommand;
		parse: 'VALUES (1, DEFAULT)' rule: #valuesCommand
]
