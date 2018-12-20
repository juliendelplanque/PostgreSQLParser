Class {
	#name : #PSQLASTBuilderDeleteSmokeTest,
	#superclass : #PSQLGrammarDeleteCrashTest,
	#traits : 'PSQLTASTBuilderSanityChecker',
	#classTraits : 'PSQLTASTBuilderSanityChecker classTrait',
	#category : #'PostgreSQL-AST-Builder-SmokeTests'
}

{ #category : #accessing }
PSQLASTBuilderDeleteSmokeTest >> parserClass [
	^ PSQLDeleteQueryASTBuilder
]
