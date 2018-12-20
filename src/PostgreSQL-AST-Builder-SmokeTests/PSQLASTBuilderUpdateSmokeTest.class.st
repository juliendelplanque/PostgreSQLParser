Class {
	#name : #PSQLASTBuilderUpdateSmokeTest,
	#superclass : #PSQLGrammarUpdateCrashTest,
	#traits : 'PSQLTASTBuilderSanityChecker',
	#classTraits : 'PSQLTASTBuilderSanityChecker classTrait',
	#category : #'PostgreSQL-AST-Builder-SmokeTests'
}

{ #category : #accessing }
PSQLASTBuilderUpdateSmokeTest >> parserClass [
	^ PSQLUpdateQueryASTBuilder
]
