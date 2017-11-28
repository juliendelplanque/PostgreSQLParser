"
I parse PostgreSQL SELECT and SELECT INTO queries.
"
Class {
	#name : #PSQLSelectQueryGrammar,
	#superclass : #PSQLTokenizer,
	#instVars : [
		'expression',
		'withClause',
		'fromClause',
		'allOrDistinctClause',
		'columnsAndAliasesSelected',
		'whereClause',
		'groupByClause',
		'havingClause',
		'windowClause',
		'unionIntersectExceptClause',
		'orderByClause',
		'limitClause',
		'offsetClause',
		'fetchClause',
		'forClause',
		'selectIntoCommandAlternative',
		'selectIntoCommandClassic',
		'intoClause',
		'selectCommand',
		'selectIntoCommand'
	],
	#category : #PostgreSQL-Parser-Core
}

{ #category : #accessing }
PSQLSelectQueryGrammar class >> dependencies [
	^ { self sqlParser }
]

{ #category : #accessing }
PSQLSelectQueryGrammar class >> sqlParser [
	^ PSQLGrammar
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> allOrDistinctClause [
	"ALL | DISTINCT [ ON ( expression [, ...] ) ]"
	^ kw all trim /
	(kw distinct trim , 
		(kw on trim ,
			openParenthesis trim ,
			(expression plus separatedBy: comma trim) ,
			closeParenthesis trim
		) optional
	)
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> asterik [
	^ (self dependencyAt: self class sqlParser) asterik
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> columnReference [
	^ (self dependencyAt: self class sqlParser) columnReference
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> columnsAndAliasesSelected [
	^ (
			((identifier , $. asParser) optional , asterik trim) / expression
		) plus separatedBy: comma trim
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> escapeStringConstant [
	^ (self dependencyAt: self class sqlParser) escapeStringConstant
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> expression [
	^ (self dependencyAt: self class sqlParser) expression
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> fetchClause [
	^ kw fetch trim , (kw first trim / kw next trim) , numericConstant trim optional , (kw rows trim / kw row trim) , kw only trim
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> forClause [
	^ kw for trim , (kw update trim / kw share trim) , (kw of trim , (expression plus separatedBy: comma trim)) optional , kw nowait trim optional
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> fromClause [
	^ (self dependencyAt: self class sqlParser) fromClause
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> groupByClause [
	^ kw group trim , kw by trim , (expression plus separatedBy: comma trim)
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> havingClause [
	^ kw having trim , (expression plus separatedBy: comma trim)
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> identifier [
	^ (self dependencyAt: self class sqlParser) identifier
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> identifierOrKeyword [
	^ (self dependencyAt: self class sqlParser) identifierOrKeyword
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> identifierWithOptionalFieldAccess [
	^ (self dependencyAt: self class sqlParser) identifierWithOptionalFieldAccess
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> intoClause [
	"INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table"
	^ kw into trim , (kw temporary trim / kw temp trim / kw unlogged trim) optional , kw table trim optional , expression trim
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> limitClause [
	^ kw limit trim , (numericConstant trim / kw all trim)
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> numericConstant [
	^ (self dependencyAt: self class sqlParser) numericConstant
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> offsetClause [
	^ kw offset trim , numericConstant trim
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> orderByClause [
	^ (self dependencyAt: self class sqlParser) orderByClause
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> selectCommand [
	"[ WITH [ RECURSIVE ] with_query [, ...] ]
	 SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
    	* | expression [ [ AS ] output_name ] [, ...]
    	[ FROM from_item [, ...] ]
    	[ WHERE condition ]
    	[ GROUP BY expression [, ...] ]
    	[ HAVING condition [, ...] ]
    	[ WINDOW window_name AS ( window_definition ) [, ...] ]
    	[ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] kw select ]
    	[ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
    	[ LIMIT { count | ALL } ]
    	[ OFFSET start [ ROW | ROWS ] ]
    	[ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
    	[ FOR { UPDATE | SHARE } [ OF table_name [, ...] ] [ NOWAIT ] [...] ]"
	^ withClause optional ,
	   kw select trim ,
	   allOrDistinctClause optional ,
		columnsAndAliasesSelected trim,
		fromClause optional ,
		whereClause optional ,
		groupByClause optional ,
		havingClause optional ,
		windowClause optional ,
		unionIntersectExceptClause optional ,
		orderByClause optional ,
		limitClause optional ,
		offsetClause optional ,
		fetchClause optional ,
		forClause optional	
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> selectIntoCommand [
	^ selectIntoCommandAlternative / selectIntoCommandClassic
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> selectIntoCommandAlternative [
	"Alternative way to construct a SELECT INTO that was found in a DB schema.
	It is similar to #selectIntoClassic but with the following construct allowed:
	
	SELECT INTO table * | columns ...
	"
	^ withClause optional ,
	   kw select trim , kw into trim , identifierWithOptionalFieldAccess trim  ,
		columnsAndAliasesSelected trim ,
		fromClause optional ,
		whereClause optional ,
		groupByClause optional ,
		havingClause optional ,
		windowClause optional ,
		unionIntersectExceptClause optional ,
		orderByClause optional ,
		limitClause optional ,
		offsetClause optional ,
		fetchClause optional ,
		forClause optional	
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> selectIntoCommandClassic [
	"[ WITH [ RECURSIVE ] with_query [, ...] ]
SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
    * | expression [ [ AS ] output_name ] [, ...]
    INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table
    [ FROM from_item [, ...] ]
    [ WHERE condition ]
    [ GROUP BY expression [, ...] ]
    [ HAVING condition [, ...] ]
    [ WINDOW window_name AS ( window_definition ) [, ...] ]
    [ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] kw select ]
    [ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
    [ LIMIT { count | ALL } ]
    [ OFFSET start [ ROW | ROWS ] ]
    [ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
    [ FOR { UPDATE | SHARE } [ OF table_name [, ...] ] [ NOWAIT ] [...] ]"
	^ withClause optional ,
	   kw select trim ,
	   allOrDistinctClause optional ,
		columnsAndAliasesSelected trim,
		intoClause ,
		fromClause optional ,
		whereClause optional ,
		groupByClause optional ,
		havingClause optional ,
		windowClause optional ,
		unionIntersectExceptClause optional ,
		orderByClause optional ,
		limitClause optional ,
		offsetClause optional ,
		fetchClause optional ,
		forClause optional	
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> simpleStringConstant [
	^ (self dependencyAt: self class sqlParser) simpleStringConstant
]

{ #category : #accessing }
PSQLSelectQueryGrammar >> start [
	^ (selectCommand / selectIntoCommand) end
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> unionIntersectExceptClause [
	^ (kw union trim / kw intersect trim / kw except trim) , (kw all trim / kw distinct trim) optional , selectCommand trim
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> whereClause [
	^ kw whereKeyword trim , expression
]

{ #category : #'select command' }
PSQLSelectQueryGrammar >> windowClause [
	self flag: #todo.
	^ nil asParser
]

{ #category : #dependencies }
PSQLSelectQueryGrammar >> withClause [
	^ (self dependencyAt: self class sqlParser) withClause
]
