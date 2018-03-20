"
I generate the visitor design pattern methods for visited entities.
"
Class {
	#name : #PSQLVisitedMethodsGenerator,
	#superclass : #ComposableModel,
	#instVars : [
		'classList',
		'codeToGenerate',
		'protocolTextInput',
		'generateButton'
	],
	#category : #PostgreSQL-DevTools
}

{ #category : #specs }
PSQLVisitedMethodsGenerator class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c | 
			c 
				newRow: [ :row |
					row
						add: #classList;
						newColumn: [ :col |
							col
								add: #protocolTextInput height: self inputTextHeight; 
								add: #codeToGenerate ] ];
				add: #generateButton height: self buttonHeight ];
		yourself
]

{ #category : #'instance creation' }
PSQLVisitedMethodsGenerator class >> open [
	<script>
	self new
		openWithSpec
]

{ #category : #accessing }
PSQLVisitedMethodsGenerator >> classList [
	^ classList
]

{ #category : #accessing }
PSQLVisitedMethodsGenerator >> codeToGenerate [
	^ codeToGenerate
]

{ #category : #actions }
PSQLVisitedMethodsGenerator >> generate [
	self classList selectedItems do: [ :class |
		self generateFor: class ]
]

{ #category : #accessing }
PSQLVisitedMethodsGenerator >> generateButton [
	^ generateButton
]

{ #category : #actions }
PSQLVisitedMethodsGenerator >> generateFor: aClass [
	| source selector |
	source := self codeToGenerate text asString format: { 'className' -> aClass name } asDictionary.
	
	selector := aClass compile: source.
	
	(aClass>>selector) protocol: self protocolTextInput text asString
]

{ #category : #initialization }
PSQLVisitedMethodsGenerator >> initializePresenter [
	self classList
		items: PSQLASTNode withAllConcreteSubclasses;
		beMultipleSelection;
		sortingBlock: [ :c1 :c2 | c1 className < c2 className ].
		
	
	self generateButton
		label: 'Generate!';
		action: [ self generate ].
		
	self protocolTextInput
		text: 'visiting'
]

{ #category : #initialization }
PSQLVisitedMethodsGenerator >> initializeWidgets [
	classList := self newList.
	
	codeToGenerate := self newText.
	
	generateButton := self newButton.
	
	protocolTextInput := self newTextInput
]

{ #category : #accessing }
PSQLVisitedMethodsGenerator >> protocolTextInput [
	^ protocolTextInput
]
