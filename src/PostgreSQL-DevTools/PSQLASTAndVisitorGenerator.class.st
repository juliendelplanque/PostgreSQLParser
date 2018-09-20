"
I am a generator that generate for a rules the associated AST and the visiting methods
"
Class {
	#name : #PSQLASTAndVisitorGenerator,
	#superclass : #Object,
	#category : #'PostgreSQL-DevTools'
}

{ #category : #'as yet unclassified' }
PSQLASTAndVisitorGenerator class >> generateASTNodeAndVisitorsMethodRule: ruleName withVisitMethodInClass: aVisitorClass [
	"self generateASTNodeAndVisitorsMethodRule: #ruleName withVisitMethodInClass: PSQLASTReflectiveVisitor"

	self generateASTNodeForRule: ruleName forVisitor: aVisitorClass.
	self generateVisitorsMethodsForRule: ruleName forVisitor: aVisitorClass
]

{ #category : #'as yet unclassified' }
PSQLASTAndVisitorGenerator class >> generateASTNodeForRule: ruleName forVisitor: aVisitorClass [
	| astClassName nodeClass |
	"PSQLASTAndVisitorGenerator generateASTNodeForRule: ruleName forVisitor: PSQLASTReflectiveVisitor"
	astClassName := 'PSQLAST' , ruleName capitalized.
	nodeClass := PSQLASTNode
		subclass: astClassName asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'PostgreSQL-AST-SQL'.
	nodeClass
		compile:
			'acceptVisitor: a' , aVisitorClass superclass name
				,
					'
	^ a' , aVisitorClass superclass name , ' visit' , astClassName , ': self'
		classified: 'visiting'
]

{ #category : #'as yet unclassified' }
PSQLASTAndVisitorGenerator class >> generateRule: ruleName inClass: aBuilderClass withVisitMethodInClass: aVisitorClass [
	| astClassName |
	"PSQLASTAndVisitorGenerator "
	astClassName := 'PSQLAST' , ruleName capitalized.
	self generateASTNodeForRule: ruleName forVisitor: aVisitorClass.
	self generateVisitorsMethodsForRule: ruleName forVisitor: aVisitorClass.
	aBuilderClass
		compile:
			ruleName
				,
					'
	^ super ' , ruleName
				,
					' psqlASTBuild: [ :tokens |
		' , astClassName , ' new. Halt now. ]'
		classified: (aBuilderClass superclass >> ruleName asSymbol) protocol
]

{ #category : #'as yet unclassified' }
PSQLASTAndVisitorGenerator class >> generateVisitorsMethodsForRule: ruleName forVisitor: aVisitorClass [
	| astClassName |
	astClassName := 'PSQLAST' , ruleName capitalized.
	aVisitorClass superclass
		compile:
			'visit' , astClassName , ': a' , astClassName
				,
					'
	^ self subclassResponsibility'
		classified: 'visiting'.
	aVisitorClass
		compile:
			'visit' , astClassName , ': a' , astClassName
				,
					'
	^ self explicitRequirement'
		classified: 'visiting'
]
