"
I am a AST builder based on libpgquery. I take an SQL string as input and returns an AST.
"
Class {
	#name : #PSQLLibpgQueryBasedASTBuilder,
	#superclass : #Object,
	#category : #'PostgreSQL-LibpgQuery-Core'
}

{ #category : #private }
PSQLLibpgQueryBasedASTBuilder >> libpgqueryParse: aString [
	^ LibpgqueryBridge new
		postgreSQLParserPath: '/Users/julien/Documents/GIT/libpg_query/examples/parse_file' asFileReference;
		parseQuery: aString
]

{ #category : #parsing }
PSQLLibpgQueryBasedASTBuilder >> parse: aString [
	| json |
	json := self libpgqueryParse: aString.
	^ json psqlJSONAccept: PSQLStatementsExtractor new
]
