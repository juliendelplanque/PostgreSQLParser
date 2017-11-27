Class {
	#name : #PSQLASTBuilderUpdateSmokeTest,
	#superclass : #PSQLGrammarUpdateCrashTest,
	#category : #PostgreSQL-AST-Builder-SmokeTests
}

{ #category : #accessing }
PSQLASTBuilderUpdateSmokeTest >> parserClass [
	^ PSQLUpdateQueryASTBuilder
]
