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
						add: #testSelectorLabel;
						add: #testSelectorPrefixTextField;
						add: #testIndexLabel;
						add: #testIndexTextField width: self inputTextHeight ] height: self inputTextHeight;
				add: #inputTextLabel height: self inputTextHeight;
				add: #inputText;
				add: #outputTextLabel height: self inputTextHeight;
				add: #outputText;
				add: #testClassLabel height: self inputTextHeight;
				add: #testClassTextField height: self inputTextHeight;
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

{ #category : #processing }
PSQLTestBuilderWidget >> compile [
	UIManager default inform: 'Test compiled'
]

{ #category : #accessing }
PSQLTestBuilderWidget >> compileButton [
	^ compileButton
]

{ #category : #initialization }
PSQLTestBuilderWidget >> initializePresenter [
	self inputText
		acceptBlock: [ :text | self textAccepted: text asString ].
		
	self outputText
		enabled: false.
		
	self testIndexTextField
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
PSQLTestBuilderWidget >> ruleLabel [
	^ ruleLabel
]

{ #category : #accessing }
PSQLTestBuilderWidget >> ruleTextField [
	^ ruleTextField
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testClassLabel [
	^ testClassLabel
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testClassTextField [
	^ testClassTextField
]

{ #category : #accessing }
PSQLTestBuilderWidget >> testIndexLabel [
	^ testIndexLabel
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
PSQLTestBuilderWidget >> testSelectorPrefixTextField [
	^ testSelectorPrefixTextField
]

{ #category : #processing }
PSQLTestBuilderWidget >> textAccepted: aString [
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
