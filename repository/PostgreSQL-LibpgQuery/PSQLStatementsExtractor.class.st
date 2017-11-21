Class {
	#name : #PSQLStatementsExtractor,
	#superclass : #PSQLJSONVisitor,
	#category : #PostgreSQL-LibpgQuery-Visitors
}

{ #category : #accessing }
PSQLStatementsExtractor >> statementKeys [
	^ self statementKeysToVisitorClasses keys
]

{ #category : #accessing }
PSQLStatementsExtractor >> statementKeysToVisitorClasses [
	^ { 
		'ViewStmt' -> PSQLLQCreateViewVisitor .
		'RuleStmt' -> PSQLLQCreateRuleVisitor .
		'CreateFunctionStmt' -> PSQLLQCreateFunctionVisitor .
		'CreateStmt' -> PSQLLQCreateTableVisitor .
		'CommentStmt' -> PSQLLQCommentVisitor .
		'TransactionStmt' -> PSQLLQTransactionVisitor .
		'CreateTrigStmt' -> PSQLLQCreateTriggerVisitor .
		'CompositeTypeStmt' -> PSQLLQCreateTypeVisitor .
		'IndexStmt' -> PSQLLQCreateIndexVisitor .
		'CreateEnumStmt' -> PSQLLQCreateEnumVisitor
	 } asDictionary
]

{ #category : #visiting }
PSQLStatementsExtractor >> visitDictionary: aDictionary [
	| visitorClass |
	(aDictionary keys size = 1 and: [ self statementKeys includes: aDictionary keys first ])
		ifFalse: [ self error: ('Statement with key(s) "{1}" not handled by the parser.' format: { aDictionary keys joinUsing: ', ' }) ].
		
	visitorClass := self statementKeysToVisitorClasses at: (aDictionary keys first).
	
	^ aDictionary values first
		psqlJSONAccept: visitorClass new
]
