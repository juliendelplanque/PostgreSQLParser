"
I parse PostgreSQL CREATE VIEW command.
"
Class {
	#name : #PSQLCreateViewGrammar,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'selectCommand',
		'createViewCommand'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLCreateViewGrammar class >> dependencies [
	^ { self selectQueryParser }
]

{ #category : #accessing }
PSQLCreateViewGrammar class >> selectQueryParser [
	^ PSQLSelectQueryGrammar
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
PSQLCreateViewGrammar >> selectCommand [
	^ (self dependencyAt: self class selectQueryParser) selectCommand
]

{ #category : #accessing }
PSQLCreateViewGrammar >> start [
	^ createViewCommand end
]
