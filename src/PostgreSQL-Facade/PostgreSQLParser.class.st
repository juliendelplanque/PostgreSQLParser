"
I am the implementation of the facade design pattern to expose the parser to users in a simplied way.

See my class side for available methods.
"
Class {
	#name : #PostgreSQLParser,
	#superclass : #Object,
	#category : #'PostgreSQL-Facade'
}

{ #category : #parsing }
PostgreSQLParser class >> parseCRUDQuery: aQueryString [
	"See instance-side method."
	^ self new parseCRUDQuery: aQueryString
]

{ #category : #parsing }
PostgreSQLParser class >> parseDeleteQuery: aQueryString [
	"See instance-side method."
	^ self new parseDeleteQuery: aQueryString
]

{ #category : #parsing }
PostgreSQLParser class >> parseInsertQuery: aQueryString [
	"See instance-side method."
	^ self new parseInsertQuery: aQueryString
]

{ #category : #parsing }
PostgreSQLParser class >> parseSelectQuery: aQueryString [
	"See instance-side method."
	^ self new parseSelectQuery: aQueryString
]

{ #category : #parsing }
PostgreSQLParser class >> parseStoredProcedureBody: storedProcedureSourceCode [
	"See instance-side method."
	^ self new parseStoredProcedureBody: storedProcedureSourceCode
]

{ #category : #parsing }
PostgreSQLParser class >> parseUpdateQuery: aQueryString [
	"See instance-side method."
	^ self new parseUpdateQuery: aQueryString
]

{ #category : #private }
PostgreSQLParser >> parse: aQueryString using: aParserClass [
	| parser astOrFailure |
	parser := aParserClass new
					preProcessor: PSQLTokenizer new comment token ==> [ :p | String new: (p stop - p start) + 1 withAll: Character space ].
	astOrFailure := parser parse: aQueryString.
	astOrFailure isPetitFailure
		ifTrue: [ PSQLParseError signalPetitFailure: astOrFailure ].
	astOrFailure setChildrenParent.
	astOrFailure sourceCode: aQueryString.
	^ astOrFailure
]

{ #category : #parsing }
PostgreSQLParser >> parseCRUDQuery: aQueryString [
	"Parses a CRUD query provided as a string and returns a AST well initialized."
	^ self parse: aQueryString using: PSQLCRUDQueryASTBuilder
]

{ #category : #parsing }
PostgreSQLParser >> parseDeleteQuery: aQueryString [
	"Parses a DELETE query provided as a string and returns a AST well initialized."
	^ self parse: aQueryString using: PSQLDeleteQueryASTBuilder
]

{ #category : #parsing }
PostgreSQLParser >> parseInsertQuery: aQueryString [
	"Parses a INSERT query provided as a string and returns a AST well initialized."
	^ self parse: aQueryString using: PSQLInsertQueryASTBuilder
]

{ #category : #parsing }
PostgreSQLParser >> parseSelectQuery: aQueryString [
	"Parses a SELECT query provided as a string and returns a AST well initialized."
	^ self parse: aQueryString using: PSQLSelectQueryASTBuilder
]

{ #category : #parsing }
PostgreSQLParser >> parseStoredProcedureBody: storedProcedureSourceCode [
	"Parses the body of a stored procedure provided as a string containing its source code and returns an AST well initialized."
	^ self parse: storedProcedureSourceCode using: PSQLPlpgSQLASTBuilder
]

{ #category : #parsing }
PostgreSQLParser >> parseUpdateQuery: aQueryString [
	"Parses a UPDATE query provided as a string and returns a AST well initialized."
	^ self parse: aQueryString using: PSQLUpdateQueryASTBuilder
]
