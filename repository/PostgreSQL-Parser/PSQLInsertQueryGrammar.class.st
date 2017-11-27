"
I parse PostgreSQL INSERT query.
"
Class {
	#name : #PSQLInsertQueryGrammar,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'expression',
		'returningClause',
		'selectCommand',
		'setClause',
		'valuesCommand',
		'withClause',
		'conflictTarget1',
		'conflictTarget2',
		'defaultValues',
		'insertCommand',
		'conflictAction',
		'conflictTarget',
		'valuesClause',
		'onConflictClause'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLInsertQueryGrammar class >> dependencies [
	^ { self sqlParser . self valuesCommandParser }
]

{ #category : #accessing }
PSQLInsertQueryGrammar class >> sqlParser [
	^ PSQLGrammar
]

{ #category : #accessing }
PSQLInsertQueryGrammar class >> valuesCommandParser [
	^ PSQLValuesGrammar
]

{ #category : #'insert command' }
PSQLInsertQueryGrammar >> conflictAction [
	"DO NOTHING
    DO UPDATE SET { column_name = { expression | DEFAULT } |
                    ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
                    ( column_name [, ...] ) = ( sub-SELECT )
                  } [, ...]
              [ WHERE condition ]"
	^ (kw do trim , kw nothing) /
	(kw do trim , kw update trim , setClause trim , (kw whereKeyword trim , expression) optional)
]

{ #category : #'insert command' }
PSQLInsertQueryGrammar >> conflictTarget [
	"( { index_column_name | ( index_expression ) } [ COLLATE collation ] [ opclass ] [, ...] ) [ WHERE index_predicate ]
	
	or
	
   ON CONSTRAINT constraint_name"
	^ conflictTarget1 / conflictTarget2
]

{ #category : #'insert command' }
PSQLInsertQueryGrammar >> conflictTarget1 [
	"( { index_column_name | ( index_expression ) } [ COLLATE collation ] [ opclass ] [, ...] ) [ WHERE index_predicate ]"
	self flag: 'TODO'. "Not sure of how to parse the rest of this..."
	^ (( openParenthesis trim , expression trim , closeParenthesis ) / identifier) ,
	"Missing something between"
	(kw whereKeyword trim , expression) optional
]

{ #category : #'insert command' }
PSQLInsertQueryGrammar >> conflictTarget2 [
	"ON CONSTRAINT constraint_name"
	^ kw on trim , kw constraint trim , identifier
]

{ #category : #'insert command' }
PSQLInsertQueryGrammar >> defaultValues [
	^ kw default trim , kw values
]

{ #category : #dependencies }
PSQLInsertQueryGrammar >> expression [
	^ (self dependencyAt: self class sqlParser) expression
]

{ #category : #'insert command' }
PSQLInsertQueryGrammar >> insertCommand [
	"[ WITH [ RECURSIVE ] with_query [, ...] ]
INSERT INTO table_name [ AS alias ] [ ( column_name [, ...] ) ]
    { DEFAULT VALUES | VALUES ( { expression | DEFAULT } [, ...] ) [, ...] | query }
    [ ON CONFLICT [ conflict_target ] conflict_action ]
    [ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]"
	
	^ withClause trim optional ,
		kw insert trim , kw into trim , identifierWithOptionalFieldAccess trim , (kw as trim , identifier) optional , 
		(openParenthesis trim , 
			(expression plus separatedBy: comma trim) , "Apparently, a column name can be generated from an expression."
		closeParenthesis trim) trim optional ,
		valuesClause trim ,
		onConflictClause trim optional ,
		returningClause trim optional
]

{ #category : #'insert command' }
PSQLInsertQueryGrammar >> onConflictClause [
	"ON CONFLICT [ conflict_target ] conflict_action"
	^ kw on trim , kw conflict trim , conflictTarget trim optional , conflictAction
]

{ #category : #dependencies }
PSQLInsertQueryGrammar >> returningClause [
	^ (self dependencyAt: self class sqlParser) returningClause
]

{ #category : #dependencies }
PSQLInsertQueryGrammar >> selectCommand [
	^ (self dependencyAt: self class sqlParser) selectCommand
]

{ #category : #dependencies }
PSQLInsertQueryGrammar >> setClause [
	^ (self dependencyAt: self class sqlParser) setClause
]

{ #category : #accessing }
PSQLInsertQueryGrammar >> start [
	^ insertCommand end
]

{ #category : #'insert command' }
PSQLInsertQueryGrammar >> valuesClause [
	"DEFAULT VALUES | VALUES ( { expression | DEFAULT } [, ...] ) [, ...] | query"
	^ defaultValues /
	valuesCommand /
	selectCommand
]

{ #category : #dependencies }
PSQLInsertQueryGrammar >> valuesCommand [
	^ (self dependencyAt: self class valuesCommandParser) valuesCommand
]

{ #category : #dependencies }
PSQLInsertQueryGrammar >> withClause [
	^ (self dependencyAt: self class sqlParser) withClause
]
