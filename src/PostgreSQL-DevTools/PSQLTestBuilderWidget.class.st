"
I am a widget helping to build tests for a PetitParser.
"
Class {
	#name : #PSQLTestBuilderWidget,
	#superclass : #ComposableModel,
	#instVars : [
		'inputText',
		'outputText',
		'ruleTextField',
		'testIndexTextField',
		'testSelectorPrefixTextField',
		'compileButton',
		'testClassTextField',
		'inputTextLabel',
		'outputTextLabel',
		'ruleLabel',
		'testIndexLabel',
		'testSelectorLabel',
		'testClassLabel'
	],
	#category : #PostgreSQL-DevTools
}

{ #category : #specs }
PSQLTestBuilderWidget class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c | 
			c 
				newRow: [ :row |
					row
						add: #ruleLabel;
						add: #ruleTextField ] height: self inputTextHeight;
				
				newRow: [ :row |
					row
						add: #testClassLabel;
						add: #testClassTextField ] height: self inputTextHeight;
				newRow: [ :row |
					row
						add: #testSelectorLabel;
						add: #testSelectorPrefixTextField;
						add: #testIndexLabel;
						add: #testIndexTextField width: self inputTextHeight ] height: self inputTextHeight;
				add: #inputTextLabel height: self inputTextHeight;
				add: #inputText;
				add: #outputTextLabel height: self inputTextHeight;
				add: #outputText;
				add: #compileButton height: self buttonHeight ];
		yourself
]

{ #category : #'instance creation' }
PSQLTestBuilderWidget class >> open [
	<script>
	| inst |
	inst :=  self new
				openWithSpec;
				yourself.
				
	inst window extent: 400@600.
	^ inst
]

{ #category : #checking }
PSQLTestBuilderWidget >> checkRuleTextField [
	| parserClass |
	parserClass := self testClass new parserClass.
	(parserClass methods anySatisfy: [ :method | method selector = self rule ])
		ifFalse: [ 
			self error: ('Rule "{1}" is not defined in "{2}".' format: { self rule . parserClass }) ]
]

{ #category : #checking }
PSQLTestBuilderWidget >> checkTestClassTextField [
	Smalltalk at: self testClassName asSymbol ifAbsent: [ 
		self error: ('Class named "{1}" does not exist in the system.' format: { self testClassName }) ]
]

{ #category : #checking }
PSQLTestBuilderWidget >> checkTestIndexTextField [
	(self testIndexString matchesRegex: '\d+')
		ifFalse: [ self error: ('"{1}" is not a valid index.' format: { self testIndexString }) ]
]

{ #category : #checking }
PSQLTestBuilderWidget >> checkTestSelectorPrefixTextField [
	self testSelectorPrefix isEmpty
		ifTrue: [ self error: 'You must provide a selector prefix for the test.' ]
]

{ #category : #checking }
PSQLTestBuilderWidget >> checkUserInputs [
	self
		checkTestClassTextField;
		checkRuleTextField;
		checkTestSelectorPrefixTextField;
		checkTestIndexTextField
]

{ #category : #processing }
PSQLTestBuilderWidget >> compile [
	(Smalltalk at: (self testClassTextField text asString asSymbol))
		compile: self outputText text asString.
	UIManager default inform: 'Test compiled'
]

{ #category : #accessing }
PSQLTestBuilderWidget >> compileButton [
	^ compileButton
]

{ #category : #initialization }
PSQLTestBuilderWidget >> initialize [
	super initialize.
	self title: 'Test builder'
]

{ #category : #initialization }
PSQLTestBuilderWidget >> initializePresenter [
	self inputText
		acceptBlock: [ :text | self textAccepted: text asString ].
		
	self outputText
		enabled: false.
	
	self testSelectorPrefixTextField
		autoAccept: true.
		
	self testClassTextField
		autoAccept: true.
		
	self ruleTextField
		autoAccept: true.
			
	self testIndexTextField
		autoAccept: true;
		text: '0'.
		
	self compileButton
		label: 'Compile test';
		action: [ self compile ].
		
	self inputTextLabel label: 'Input SQL:'.
	
	self outputTextLabel label: 'Test source code:'.
	
	self ruleLabel label: 'Rule:'.
	
	self testIndexLabel label: 'Test index:'.
	
	self testSelectorLabel label: 'Test selector:'.
	
	self testClassLabel label: 'Test class:'
]

{ #category : #initialization }
PSQLTestBuilderWidget >> initializeWidgets [
	inputTextLabel := self newLabel.
	inputText := self newText.
	outputTextLabel := self newLabel.
	outputText := self newText.
	ruleLabel := self newLabel.
	ruleTextField := self newTextInput.
	testIndexLabel := self newLabel.
	testIndexTextField := self newTextInput.
	testSelectorLabel := self newLabel.
	testSelectorPrefixTextField := self newTextInput.
	compileButton := self newButton.
	testClassLabel := self newLabel.
	testClassTextField := self newTextInput
]

{ #category : #accessing }
PSQLTestBuilderWidget >> inputText [
	^ inputText
]

{ #category : #accessing }
PSQLTestBuilderWidget >> inputTextLabel [
	^ inputTextLabel
]

{ #category : #accessing }
PSQLTestBuilderWidget >> outputText [
	^ outputText
]

{ #category : #accessing }
PSQLTestBuilderWidget >> outputTextLabel [
	^ outputTextLabel
]

{ #category : #accessing }
PSQLTestBuilderWidget >> rule [
	^ self ruleTextField text asString
]

{ #category : #accessing }
PSQLTestBuilderWidget >> ruleLabel [
	^ ruleLabel
]

{ #category : #accessing }
PSQLTestBuilderWidget >> ruleTextField [
	^ ruleTextField
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testClass [
	^ Smalltalk at: self testClassName asSymbol
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testClassLabel [
	^ testClassLabel
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testClassName [
	^ self testClassTextField text asString
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testClassTextField [
	^ testClassTextField
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testIndex [
	^ self testIndexString asNumber
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testIndexLabel [
	^ testIndexLabel
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testIndexString [
	^ self testIndexTextField text asString
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testIndexTextField [
	^ testIndexTextField
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testSelectorLabel [
	^ testSelectorLabel
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testSelectorPrefix [
	^ self testSelectorPrefixTextField text asString
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testSelectorPrefixTextField [
	^ testSelectorPrefixTextField
]

{ #category : #processing }
PSQLTestBuilderWidget >> textAccepted: aString [
	self checkUserInputs.
	
	self outputText
		text: ('{1}{2}
	self
		parse: ''{3}'' rule: #{4}' format: { 
			self testSelectorPrefixTextField text asString.
			self testIndexTextField text asString .
			(((aString lines collect: #trimmed) joinUsing: ' ') splitOn: $') joinUsing: '''''' .
			self ruleTextField text asString 
		}).
		
	self testIndexTextField text: (self testIndexTextField text asString asNumber + 1) asString
]
