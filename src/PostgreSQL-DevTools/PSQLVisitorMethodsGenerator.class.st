"
I generate the visitor design pattern methods for visitor entity.
"
Class {
	#name : #PSQLVisitorMethodsGenerator,
	#superclass : #PSQLVisitedMethodsGenerator,
	#instVars : [
		'visitorToGenerateTextInput',
		'visitorSuperClass',
		'packageTextInput'
	],
	#category : #'PostgreSQL-DevTools'
}

{ #category : #specs }
PSQLVisitorMethodsGenerator class >> defaultSpec [
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
				add: #visitorSuperClass height: self inputTextHeight;
				add: #visitorToGenerateTextInput height: self inputTextHeight;
				add: #packageTextInput height: self inputTextHeight;
				add: #generateButton height: self buttonHeight ];
		yourself
]

{ #category : #'instance creation' }
PSQLVisitorMethodsGenerator class >> open [
	<script>
	"Just for the button to appear in the browser."
	super open
]

{ #category : #actions }
PSQLVisitorMethodsGenerator >> generate [
	| visitorClass |
	visitorClass := self generateVisitorClass.
	
	self generateVisitorMethodsFor: visitorClass
		
]

{ #category : #actions }
PSQLVisitorMethodsGenerator >> generateVisitorClass [
	self class environment
		at: self visitorToGenerateTextInput text asString asSymbol ifPresent: [ :c | ^ c ].
	
	(self class environment
		at: self visitorSuperClass text asString asSymbol)
		subclass: self visitorToGenerateTextInput text asString asSymbol
		instanceVariableNames: ''
		classVariableNames: ''
		package: self packageTextInput text asString.
	
	^ self class environment
		at: self visitorToGenerateTextInput text asString asSymbol
]

{ #category : #actions }
PSQLVisitorMethodsGenerator >> generateVisitorMethodsFor: visitorClass [
	self classList selectedItems do: [ :class |
		|selector|
		selector := visitorClass compile: (self codeToGenerate text asString format: { 'className' -> class name } asDictionary).
		(visitorClass>>selector) protocol: self protocolTextInput text asString ]
]

{ #category : #initialization }
PSQLVisitorMethodsGenerator >> initializePresenter [
	super initializePresenter.
	
	self packageTextInput
		ghostText: 'Package to put the visitor'.
		
	self visitorToGenerateTextInput
		ghostText: 'Visitor class name'.
		
	self visitorSuperClass
		ghostText: 'Visitor super class'
]

{ #category : #initialization }
PSQLVisitorMethodsGenerator >> initializeWidgets [
	super initializeWidgets.
	
	visitorToGenerateTextInput := self newTextInput.
	packageTextInput := self newTextInput.
	visitorSuperClass := self newTextInput
]

{ #category : #accessing }
PSQLVisitorMethodsGenerator >> packageTextInput [
	^ packageTextInput
]

{ #category : #accessing }
PSQLVisitorMethodsGenerator >> visitorSuperClass [
	^ visitorSuperClass
]

{ #category : #accessing }
PSQLVisitorMethodsGenerator >> visitorToGenerateTextInput [
	^ visitorToGenerateTextInput
]
