Class {
	#name : #PSQLPetitParserSyntaxHighlighter,
	#superclass : #SSHSyntaxHighlighter,
	#category : #PostgreSQL-Highlighter
}

{ #category : #accessing }
PSQLPetitParserSyntaxHighlighter >> attributeForRule: aSymbol [
	^ { 
		#oneLineComment -> (TextColor color: Color gray lighter).
		#multiLineComment -> (TextColor color: Color gray lighter).
		#numericConstant -> (TextColor color: Color green darker).
		#simpleStringConstant -> (TextColor color: Color yellow lighter).
		#semicolon -> (TextColor color: Color gray lighter lighter).
		#keyword -> (TextColor color: Color purple lighter lighter lighter)
	} asDictionary at: aSymbol ifAbsent: [ nil ]
]

{ #category : #highlighting }
PSQLPetitParserSyntaxHighlighter >> highlight: aText [
	| colorationIntervals |
	colorationIntervals := PSQLHighlighter new
									parse: aText asString trimRight.
	colorationIntervals isPetitFailure
		ifTrue: [ ^ self ].
		
	colorationIntervals do: [ :colorationInterval |
		|attribute|
		attribute := self attributeForRule: colorationInterval rule.
		attribute ifNotNil: [ aText addAttribute: attribute from: colorationInterval begin to: colorationInterval end ] ]
]
