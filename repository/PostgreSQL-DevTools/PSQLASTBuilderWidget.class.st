Class {
	#name : #PSQLASTBuilderWidget,
	#superclass : #ComposableModel,
	#instVars : [
		'sqlCodeText',
		'inspectButton'
	],
	#category : #PostgreSQL-DevTools
}

{ #category : #specs }
PSQLASTBuilderWidget class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c | 
			c 
				add: #sqlCodeText;
				add: #inspectButton height: self buttonHeight ];
		yourself
]

{ #category : #'instance creation' }
PSQLASTBuilderWidget class >> open [
	<script>
	self new
		openWithSpec
]

{ #category : #initialization }
PSQLASTBuilderWidget >> initialize [
	super initialize.
	self
		title: 'PL/pgSQL AST builder'
]

{ #category : #initialization }
PSQLASTBuilderWidget >> initializePresenter [
	self inspectButton
		label: 'Inspect!';
		action: [ self inspectAST ]
]

{ #category : #initialization }
PSQLASTBuilderWidget >> initializeWidgets [
	sqlCodeText := self newText.
	inspectButton := self newButton
]

{ #category : #actions }
PSQLASTBuilderWidget >> inspectAST [
	(PSQLExpressionASTBuilder new plpgsqlBody parse: self sqlCodeText text asString onError: [ :ppFailure | UIManager default inform: 'Could not parse the input.'. ppFailure ]) inspect
]

{ #category : #accessing }
PSQLASTBuilderWidget >> inspectButton [
	^ inspectButton
]

{ #category : #accessing }
PSQLASTBuilderWidget >> sqlCodeText [
	^ sqlCodeText
]
