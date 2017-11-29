"
I hold part of the PostgreSQL grammar that are shared accross multiple parsers.
"
Class {
	#name : #PSQLSharedGrammar,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'expression',
		'selectCommand',
		'insertCommand',
		'updateCommand',
		'deleteCommand',
		'orderByClause',
		'returningClause',
		'updateDeleteWhereClause',
		'withClause',
		'withQuery',
		'setClause',
		'setItem1',
		'setItem2',
		'setItem3'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLSharedGrammar class >> crudQueryParser [
	^ PSQLCRUDQueryGrammar
]

{ #category : #accessing }
PSQLSharedGrammar class >> dependencies [
	^ { self crudQueryParser . self sqlParser }
]

{ #category : #accessing }
PSQLSharedGrammar class >> sqlParser [
	^ PSQLGrammar
]

{ #category : #dependencies }
PSQLSharedGrammar >> deleteCommand [
	^ (self dependencyAt: self class crudQueryParser) deleteCommand
]

{ #category : #dependencies }
PSQLSharedGrammar >> expression [
	^ (self dependencyAt: self class sqlParser) expression
]

{ #category : #dependencies }
PSQLSharedGrammar >> identifier [
	^ (self dependencyAt: self class sqlParser) identifier
]

{ #category : #dependencies }
PSQLSharedGrammar >> insertCommand [
	^ (self dependencyAt: self class crudQueryParser) insertCommand
]

{ #category : #shared }
PSQLSharedGrammar >> orderByClause [
	^ kw order trim , kw by trim ,
		((expression ,
		(kw asc / kw desc) trim optional,
		(kw nulls , (kw first / kw last) trim) trim optional) plus separatedBy: comma trim)
]

{ #category : #shared }
PSQLSharedGrammar >> returningClause [
	"RETURNING * | output_expression [ [ AS ] output_name ] [, ...]"
	
	^ kw returning trim ,
		((asterik / (expression trim , (kw as trim optional , identifier) optional)) plus separatedBy: comma trim)
]

{ #category : #dependencies }
PSQLSharedGrammar >> selectCommand [
	^ (self dependencyAt: self class crudQueryParser) selectCommand
]

{ #category : #'shared - set clause' }
PSQLSharedGrammar >> setClause [
	"SET { column_name = { expression | DEFAULT } |
                    ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
                    ( column_name [, ...] ) = ( sub-SELECT )
                  } [, ...]"
	^ kw set trim ,
	((setItem1 / setItem2 / setItem3) plus separatedBy: comma trim)
]

{ #category : #'shared - set clause' }
PSQLSharedGrammar >> setItem1 [
	"column_name = { expression | DEFAULT }"
	^ identifier trim , $= asParser trim , (kw default / expression)
]

{ #category : #'shared - set clause' }
PSQLSharedGrammar >> setItem2 [
	"( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] )"
	^ openParenthesis trim , (identifier plus separatedBy: comma trim) trim , closeParenthesis trim ,
	$= asParser trim ,
	openParenthesis trim , ((kw default / expression) plus separatedBy: comma trim) , closeParenthesis
]

{ #category : #'shared - set clause' }
PSQLSharedGrammar >> setItem3 [
	"( column_name [, ...] ) = ( sub-SELECT )"
	^ openParenthesis trim , (identifier plus separatedBy: comma trim) , closeParenthesis trim ,
	$= asParser trim ,
	openParenthesis trim , selectCommand trim , closeParenthesis trim
]

{ #category : #dependencies }
PSQLSharedGrammar >> updateCommand [
	^ (self dependencyAt: self class crudQueryParser) updateCommand
]

{ #category : #shared }
PSQLSharedGrammar >> updateDeleteWhereClause [
	"WHERE condition | WHERE CURRENT OF cursor_name"
	^ kw whereKeyword trim , ((kw current trim , kw of trim , identifier) / expression)
]

{ #category : #shared }
PSQLSharedGrammar >> withClause [
	^ kw with trim , kw recursive trim optional , (withQuery separatedBy: comma trim)
]

{ #category : #shared }
PSQLSharedGrammar >> withQuery [
	^ identifier trim ,
	  		(openParenthesis trim ,
			(identifier separatedBy: comma trim ) ,
			closeParenthesis trim) optional ,
	  kw as trim ,
	  openParenthesis trim ,
	  (selectCommand / insertCommand / updateCommand / deleteCommand) ,
	  closeParenthesis trim
]
