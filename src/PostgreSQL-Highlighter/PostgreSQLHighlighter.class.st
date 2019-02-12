"
I am the implementation of the facade design pattern to expose the highlighter to users in a simplied way.

I can either be instantiated or my class side can be directly used for scripting.
"
Class {
	#name : #PostgreSQLHighlighter,
	#superclass : #Object,
	#category : #'PostgreSQL-Highlighter'
}

{ #category : #highlighting }
PostgreSQLHighlighter class >> highlightDeleteQuery: aQueryString [
	^ self new highlightDeleteQuery: aQueryString
]

{ #category : #highlighting }
PostgreSQLHighlighter class >> highlightInsertQuery: aQueryString [
	^ self new highlightInsertQuery: aQueryString
]

{ #category : #highlighting }
PostgreSQLHighlighter class >> highlightSelectQuery: aQueryString [
	^ self new highlightSelectQuery: aQueryString
]

{ #category : #highlighting }
PostgreSQLHighlighter class >> highlightStoredProcedureBody: storedProcedureSourceCode [
	^ self new highlightStoredProcedureBody: storedProcedureSourceCode
]

{ #category : #highlighting }
PostgreSQLHighlighter class >> highlightUpdateQuery: aQueryString [
	^ self new highlightUpdateQuery: aQueryString
]

{ #category : #private }
PostgreSQLHighlighter >> highlightCRUDQuery: aQueryString usingGrammar: aParserClass [
	| text |
	text := aQueryString asText.
	self highlightKeywordsInText: text.
	self highlightTokensInText: text.
	PPTextHighlighter new
		parser: aParserClass new;
		addAttribute: TextEmphasis italic for: #columnAccess;
		highlight: text.
	^ text
]

{ #category : #highlighting }
PostgreSQLHighlighter >> highlightDeleteQuery: aQueryString [
	^ self highlightCRUDQuery: aQueryString usingGrammar: PSQLDeleteQueryGrammar
]

{ #category : #highlighting }
PostgreSQLHighlighter >> highlightInsertQuery: aQueryString [
	^ self highlightCRUDQuery: aQueryString usingGrammar: PSQLInsertQueryGrammar
]

{ #category : #private }
PostgreSQLHighlighter >> highlightKeywordsInText: aText [
	PPTextHighlighter new
		parser: (PSQLKeywordsParser new / #any asParser) star end;
		bold: #keyword;
		highlight: aText.
]

{ #category : #highlighting }
PostgreSQLHighlighter >> highlightSelectQuery: aQueryString [
	^ self highlightCRUDQuery: aQueryString usingGrammar: PSQLSelectQueryGrammar
]

{ #category : #highlighting }
PostgreSQLHighlighter >> highlightStoredProcedureBody: storedProcedureSourceCode [
	| text |
	text := storedProcedureSourceCode asText.
	self highlightKeywordsInText: text.
	self highlightTokensInText: text.
	PPTextHighlighter new
		parser: PSQLPlpgSQLGrammar new;
		addAttribute: TextEmphasis italic for: #identifier;
		highlight: text.
	^ text
]

{ #category : #private }
PostgreSQLHighlighter >> highlightTokensInText: aText [
	PPTextHighlighter new
		parser: PSQLTokenizer new;
		color: #comment with: Color gray;
		color: #constant with: Color yellow;
		color: #identifier with: Color red;
		highlight: aText.
]

{ #category : #highlighting }
PostgreSQLHighlighter >> highlightUpdateQuery: aQueryString [
	^ self highlightCRUDQuery: aQueryString usingGrammar: PSQLUpdateQueryGrammar
]
