Class {
	#name : #PSQLASTBuilderInsertSmokeTest,
	#superclass : #PSQLGrammarInsertCrashTest,
	#category : #PostgreSQL-AST-Builder-SmokeTests
}

{ #category : #accessing }
PSQLASTBuilderInsertSmokeTest >> parserClass [
	^ PSQLInsertQueryASTBuilder
]
