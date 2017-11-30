"
I parse PostgreSQL CREATE VIEW command.
"
Class {
	#name : #PSQLCreateViewGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'selectCommand',
		'createViewCommand',
		'kw',
		'identifier',
		'openParenthesis',
		'comma',
		'closeParenthesis',
		'identifierOrKeyword'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLCreateViewGrammar class >> dependencies [
	^ { self selectQueryParser . self tokenParser }
]

{ #category : #accessing }
PSQLCreateViewGrammar class >> ignoredNames [ 
	^ super ignoredNames , #(kw)
]

{ #category : #accessing }
PSQLCreateViewGrammar class >> selectQueryParser [
	^ PSQLSelectQueryGrammar
]

{ #category : #accessing }
PSQLCreateViewGrammar class >> tokenParser [
	^ PSQLTokenizer
]

{ #category : #dependencies }
PSQLCreateViewGrammar >> closeParenthesis [
	^ (self dependencyAt: self class tokenParser) closeParenthesis
]

{ #category : #dependencies }
PSQLCreateViewGrammar >> comma [
	^ (self dependencyAt: self class tokenParser) comma
]

{ #category : #'create view command' }
PSQLCreateViewGrammar >> createViewCommand [
	"CREATE [ OR REPLACE ] [ TEMP | TEMPORARY ] VIEW name [ ( column_name [, ...] ) ]
    [ WITH ( kw view_option_name [= kw view_option_value] [, ... ] ) ]
    AS query"
	^ kw create trim ,
		(kw or trim , kw replace) trim optional ,
		(kw temporary / kw temp) trim optional ,
		kw view trim ,
		identifier trim , 
		(openParenthesis trim ,
			(identifier plus separatedBy: comma trim) ,
		closeParenthesis trim) trim optional ,
		(kw with trim , openParenthesis trim ,
			((identifierOrKeyword trim , ($= asParser trim , identifierOrKeyword trim) optional ) plus separatedBy: comma trim) , 
		closeParenthesis trim) trim optional ,
		kw as trim ,
		selectCommand trim
]

{ #category : #dependencies }
PSQLCreateViewGrammar >> identifier [
	^ (self dependencyAt: self class tokenParser) identifier
]

{ #category : #dependencies }
PSQLCreateViewGrammar >> identifierOrKeyword [
	^ (self dependencyAt: self class tokenParser) identifierOrKeyword
]

{ #category : #initialization }
PSQLCreateViewGrammar >> initialize [
	super initialize.
	kw := PSQLKeywordsParser new
]

{ #category : #dependencies }
PSQLCreateViewGrammar >> openParenthesis [
	^ (self dependencyAt: self class tokenParser) openParenthesis
]

{ #category : #dependencies }
PSQLCreateViewGrammar >> selectCommand [
	^ (self dependencyAt: self class selectQueryParser) selectCommand
]

{ #category : #accessing }
PSQLCreateViewGrammar >> start [
	^ createViewCommand end
]
