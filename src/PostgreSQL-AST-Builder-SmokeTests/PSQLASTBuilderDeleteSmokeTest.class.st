Class {
	#name : #PSQLASTBuilderDeleteSmokeTest,
	#superclass : #PSQLGrammarDeleteCrashTest,
	#category : #PostgreSQL-AST-Builder-SmokeTests
}

{ #category : #accessing }
PSQLASTBuilderDeleteSmokeTest >> parserClass [
	^ PSQLDeleteQueryASTBuilder
]
