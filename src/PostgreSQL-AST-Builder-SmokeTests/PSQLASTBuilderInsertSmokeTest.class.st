Class {
	#name : #PSQLASTBuilderInsertSmokeTest,
	#superclass : #PSQLGrammarInsertCrashTest,
	#traits : 'PSQLTASTBuilderSanityChecker',
	#classTraits : 'PSQLTASTBuilderSanityChecker classTrait',
	#category : #'PostgreSQL-AST-Builder-SmokeTests'
}

{ #category : #accessing }
PSQLASTBuilderInsertSmokeTest >> parserClass [
	^ PSQLInsertQueryASTBuilder
]
