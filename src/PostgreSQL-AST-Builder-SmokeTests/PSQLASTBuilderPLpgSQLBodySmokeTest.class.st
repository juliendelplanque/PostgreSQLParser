Class {
	#name : #PSQLASTBuilderPLpgSQLBodySmokeTest,
	#superclass : #PSQLGrammarPLpgSQLBodyCrashTest,
	#traits : 'PSQLTASTBuilderSanityChecker',
	#classTraits : 'PSQLTASTBuilderSanityChecker classTrait',
	#category : #'PostgreSQL-AST-Builder-SmokeTests'
}

{ #category : #accessing }
PSQLASTBuilderPLpgSQLBodySmokeTest >> parserClass [
	^ PSQLPlpgSQLASTBuilder
]
