"
I parse PostgreSQL DELETE query.
"
Class {
	#name : #PSQLDeleteQueryGrammar,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'usingClause',
		'expression',
		'withClause',
		'updateDeleteWhereClause',
		'returningClause',
		'deleteCommand'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLDeleteQueryGrammar class >> dependencies [
	^ { self sqlParser }
]

{ #category : #accessing }
PSQLDeleteQueryGrammar class >> sqlParser [
	^ PSQLGrammar
]

{ #category : #'delete command' }
PSQLDeleteQueryGrammar >> deleteCommand [
	"https://www.postgresql.org/docs/9.6/static/sql-delete.html
	[ WITH [ RECURSIVE ] with_query [, ...] ]
		DELETE FROM [ ONLY ] table_name [ * ] [ [ AS ] alias ]
   		[ USING using_list ]
    	[ WHERE condition | WHERE CURRENT OF cursor_name ]
    	[ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]"
	^ withClause trim optional ,
	kw delete trim , kw from trim , kw only trim optional , identifierWithOptionalFieldAccess trim , asterik trim optional , (kw as trim optional , identifier) optional ,
		usingClause optional ,
		updateDeleteWhereClause trim optional ,
		returningClause trim optional
]

{ #category : #accessing }
PSQLDeleteQueryGrammar >> expression [
	^ (self dependencyAt: self class sqlParser) expression
]

{ #category : #accessing }
PSQLDeleteQueryGrammar >> returningClause [
	^ (self dependencyAt: self class sqlParser) returningClause
]

{ #category : #accessing }
PSQLDeleteQueryGrammar >> start [
	^ deleteCommand end
]

{ #category : #accessing }
PSQLDeleteQueryGrammar >> updateDeleteWhereClause [
	^ (self dependencyAt: self class sqlParser) updateDeleteWhereClause
]

{ #category : #'delete command' }
PSQLDeleteQueryGrammar >> usingClause [
	"USING using_list"
	^ kw using trim , (expression separatedBy: comma trim)
]

{ #category : #accessing }
PSQLDeleteQueryGrammar >> withClause [
	^ (self dependencyAt: self class sqlParser) withClause
]
