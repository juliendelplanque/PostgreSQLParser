"
I parse PostgreSQL UPDATE query.
"
Class {
	#name : #PSQLUpdateQueryGrammar,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'updateCommand',
		'fromClause',
		'returningClause',
		'withClause',
		'updateDeleteWhereClause',
		'setClause'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLUpdateQueryGrammar class >> dependencies [
	^ { self sqlParser . self fromClauseParser . self sharedParser }
]

{ #category : #accessing }
PSQLUpdateQueryGrammar class >> fromClauseParser [
	^ PSQLFromClauseGrammar
]

{ #category : #accessing }
PSQLUpdateQueryGrammar class >> sharedParser [
	^ PSQLSharedGrammar
]

{ #category : #accessing }
PSQLUpdateQueryGrammar class >> sqlParser [
	^ PSQLGrammar
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> fromClause [
	^ (self dependencyAt: self class fromClauseParser) fromClause
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> identifier [
	^ (self dependencyAt: self class sqlParser) identifier
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> identifierOrKeyword [
	^ (self dependencyAt: self class sqlParser) identifierOrKeyword
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> identifierWithOptionalFieldAccess [
	^ (self dependencyAt: self class sqlParser) identifierWithOptionalFieldAccess
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> returningClause [
	^ (self dependencyAt: self class sharedParser) returningClause
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> setClause [
	^ (self dependencyAt: self class sharedParser) setClause
]

{ #category : #'update command' }
PSQLUpdateQueryGrammar >> updateCommand [
	"https://www.postgresql.org/docs/9.6/static/sql-update.html
	[ WITH [ RECURSIVE ] with_query [, ...] ]
		UPDATE [ ONLY ] table_name [ * ] [ [ AS ] alias ]
    	SET { column_name = { expression | DEFAULT } |
          ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
          ( column_name [, ...] ) = ( sub-SELECT )
        } [, ...]
    	[ FROM from_list ]
    	[ WHERE condition | WHERE CURRENT OF cursor_name ]
    	[ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]"
	^ withClause trim optional ,
		kw update trim , kw only trim optional , identifierWithOptionalFieldAccess trim , asterik trim optional , (kw as trim optional , identifier) optional ,
		setClause trim ,
		fromClause trim optional ,
		updateDeleteWhereClause trim optional ,
		returningClause trim optional
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> updateDeleteWhereClause [
	^ (self dependencyAt: self class sharedParser) updateDeleteWhereClause
]

{ #category : #dependencies }
PSQLUpdateQueryGrammar >> withClause [
	^ (self dependencyAt: self class sharedParser) withClause
]
