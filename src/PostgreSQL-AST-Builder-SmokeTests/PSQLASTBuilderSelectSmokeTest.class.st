Class {
	#name : #PSQLASTBuilderSelectSmokeTest,
	#superclass : #PSQLGrammarSelectCrashTest,
	#traits : 'PSQLTASTBuilderSanityChecker',
	#classTraits : 'PSQLTASTBuilderSanityChecker classTrait',
	#category : #'PostgreSQL-AST-Builder-SmokeTests'
}

{ #category : #accessing }
PSQLASTBuilderSelectSmokeTest >> parserClass [
	^ PSQLSelectQueryASTBuilder
]
