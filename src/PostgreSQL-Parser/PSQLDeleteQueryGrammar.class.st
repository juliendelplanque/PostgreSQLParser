"
I parse PostgreSQL DELETE query.
"
Class {
	#name : #PSQLDeleteQueryGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'usingClause',
		'expression',
		'withClause',
		'updateDeleteWhereClause',
		'returningClause',
		'deleteCommand',
		'kw',
		'identifierWithOptionalFieldAccess',
		'asterik',
		'identifier',
		'comma'
	],
	#category : #'PostgreSQL-Parser-Grammars-CRUD'
}

{ #category : #accessing }
PSQLDeleteQueryGrammar class >> dependencies [
	^ { self sqlParser . self sharedParser . self tokenParser }
]

{ #category : #example }
PSQLDeleteQueryGrammar class >> example [
	^ self parse: 'DELETE FROM tasks WHERE status = ''DONE'' RETURNING *'
]

{ #category : #accessing }
PSQLDeleteQueryGrammar class >> ignoredNames [ 
	^ super ignoredNames , #(kw)
]

{ #category : #accessing }
PSQLDeleteQueryGrammar class >> sharedParser [
	^ PSQLSharedGrammar
]

{ #category : #accessing }
PSQLDeleteQueryGrammar class >> sqlParser [
	^ PSQLExpressionGrammar
]

{ #category : #accessing }
PSQLDeleteQueryGrammar class >> tokenParser [
	^ PSQLTokenizer
]

{ #category : #dependencies }
PSQLDeleteQueryGrammar >> asterik [
	^ (self dependencyAt: self class tokenParser) asterik
]

{ #category : #dependencies }
PSQLDeleteQueryGrammar >> comma [
	^ (self dependencyAt: self class tokenParser) comma
]

{ #category : #accessing }
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

{ #category : #dependencies }
PSQLDeleteQueryGrammar >> expression [
	^ (self dependencyAt: self class sqlParser) expression
]

{ #category : #dependencies }
PSQLDeleteQueryGrammar >> identifier [
	^ (self dependencyAt: self class tokenParser) identifier
]

{ #category : #dependencies }
PSQLDeleteQueryGrammar >> identifierWithOptionalFieldAccess [
	^ (self dependencyAt: self class tokenParser) identifierWithOptionalFieldAccess
]

{ #category : #initialization }
PSQLDeleteQueryGrammar >> initialize [
	super initialize.
	kw := PSQLKeywordsParser new
]

{ #category : #dependencies }
PSQLDeleteQueryGrammar >> returningClause [
	^ (self dependencyAt: self class sharedParser) returningClause
]

{ #category : #accessing }
PSQLDeleteQueryGrammar >> start [
	^ deleteCommand end
]

{ #category : #dependencies }
PSQLDeleteQueryGrammar >> updateDeleteWhereClause [
	^ (self dependencyAt: self class sharedParser) updateDeleteWhereClause
]

{ #category : #accessing }
PSQLDeleteQueryGrammar >> usingClause [
	"USING using_list"
	^ kw using trim , (expression separatedBy: comma trim)
]

{ #category : #dependencies }
PSQLDeleteQueryGrammar >> withClause [
	^ (self dependencyAt: self class sharedParser) withClause
]
