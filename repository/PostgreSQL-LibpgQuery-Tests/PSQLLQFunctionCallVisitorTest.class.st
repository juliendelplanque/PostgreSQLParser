"
A PSQLLQFunctionCallVisitorTest is a test class for testing the behavior of PSQLLQFunctionCallVisitor
"
Class {
	#name : #PSQLLQFunctionCallVisitorTest,
	#superclass : #TestCase,
	#category : #PostgreSQL-LibpgQuery-Tests
}

{ #category : #samples }
PSQLLQFunctionCallVisitorTest >> sampleDict1 [
	^ ((Dictionary new) add: ('FuncCall'->((Dictionary new) add: ('funcname'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('String'->((Dictionary new) add: ('str'->'count'); yourself)); yourself); yourself)); add: ('args'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('ColumnRef'->((Dictionary new) add: ('fields'->((Array new: 1) at: 1 put: ((Dictionary new) add: ('String'->((Dictionary new) add: ('str'->'x'); yourself)); yourself); yourself)); add: ('location'->13); yourself)); yourself); yourself)); add: ('location'->7); yourself)); yourself)
]

{ #category : #tests-visiting }
PSQLLQFunctionCallVisitorTest >> testVisitDictionary [
	| node |
	node := self sampleDict1 psqlJSONAccept: PSQLLQFunctionCallVisitor new.
	
	self
		assert: node class equals: PSQLASTFunctionCall;
		assert: node functionIdentifier class equals: PSQLASTIdentifier;
		assert: node functionIdentifier identifier equals: 'count';
		assert: node argumentsList class equals: Array;
		assert: node argumentsList size equals: 1;
		assert: node argumentsDictionary class equals: Dictionary;
		assert: node argumentsDictionary isEmpty
]
