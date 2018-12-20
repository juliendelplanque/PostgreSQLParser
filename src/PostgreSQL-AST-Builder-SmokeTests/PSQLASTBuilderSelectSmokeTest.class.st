Class {
	#name : #PSQLASTBuilderSelectSmokeTest,
	#superclass : #PSQLGrammarSelectCrashTest,
	#category : #'PostgreSQL-AST-Builder-SmokeTests'
}

{ #category : #accessing }
PSQLASTBuilderSelectSmokeTest >> parserClass [
	^ PSQLSelectQueryASTBuilder
]
