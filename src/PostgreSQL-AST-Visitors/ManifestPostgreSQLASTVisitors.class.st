"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPostgreSQLASTVisitors,
	#superclass : #PackageManifest,
	#category : #'PostgreSQL-AST-Visitors'
}

{ #category : #'code-critics' }
ManifestPostgreSQLASTVisitors class >> ruleRBEmptyExceptionHandlerRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PSQLReferenciesSolver #resolve: #false)) #'2018-07-04T11:18:21.862163+02:00') )
]
