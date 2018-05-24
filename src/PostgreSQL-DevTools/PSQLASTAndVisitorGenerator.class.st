"
I am a generator that generate for a rules the associated AST and the visiting methods
"
Class {
	#name : #PSQLASTAndVisitorGenerator,
	#superclass : #Object,
	#category : #'PostgreSQL-DevTools'
}

{ #category : #'as yet unclassified' }
PSQLASTAndVisitorGenerator class >> generateRule: ruleName inClass: aClass withVisitMethodInClass: aVisitorClass [
	| astClassName nodeClass |
	astClassName := 'PSQLAST' , ruleName capitalized.

	nodeClass := PSQLASTNode
		subclass: astClassName asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'PostgreSQL-AST-SQL'.

	nodeClass compile: 'acceptVisitor: a', aVisitorClass superclass name, '
	^ a', aVisitorClass superclass name, ' visit', astClassName ,': self'  classified: 'visiting'.
	
	aVisitorClass superclass compile: 'visit', astClassName ,': a', astClassName, '
	^ self subclassResponsibility'  classified: 'visiting'.
	
	aVisitorClass compile: 'visit', astClassName ,': a', astClassName, '
	^ self explicitRequirement'  classified: 'visiting'.

	aClass
		compile:
			ruleName
				,
					'
	^ super ' , ruleName
				,
					' psqlASTBuild: [ :tokens |
		' , astClassName , ' new. Halt now. ]'
		classified: (aClass superclass >> ruleName asSymbol) protocol
]
