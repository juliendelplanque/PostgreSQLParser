"
I convert function call dictionary to a PSQLASTFunctionCall.
"
Class {
	#name : #PSQLLQFunctionCallVisitor,
	#superclass : #PSQLJSONVisitor,
	#category : #PostgreSQL-LibpgQuery-Visitors
}

{ #category : #visiting }
PSQLLQFunctionCallVisitor >> ensureArgumentsDictionary: functionCallNode from: aDictionary [
	self assert: (aDictionary includesKey: 'args').
	
	functionCallNode
		argumentsDictionary: ((aDictionary at: 'args')
								select: [ :dict | dict keys asSet = (Set with: 'NamedArgExpr') ]
								thenCollect: [ :dict | 
									PSQLASTIdentifier identifier: ((dict at: 'NamedArgExpr') at: 'name') 
										-> (((dict at: 'NamedArgExpr') at: 'arg') ) ]) asDictionary
]

{ #category : #visiting }
PSQLLQFunctionCallVisitor >> ensureArgumentsList: functionCallNode from: aDictionary [
	self assert: (aDictionary includesKey: 'args').
	
	functionCallNode
		argumentsList: ((aDictionary at: 'args')
								reject: [ :dict | dict keys asSet = (Set with: 'NamedArgExpr') ]
								thenCollect: [ :dict | dict psqlJSONAccept: PSQLLQExpressionVisitor new ])
]

{ #category : #visiting }
PSQLLQFunctionCallVisitor >> ensureIdentifier: functionCallNode from: aDictionary [
	self assert: (aDictionary includesKey: 'funcname').
	
	functionCallNode
		functionIdentifier: (PSQLASTIdentifier identifier: (aDictionary at: 'funcname') extractString first)
]

{ #category : #visiting }
PSQLLQFunctionCallVisitor >> visitDictionary: aDictionary [
	| functionCallNode |
	self assert: aDictionary keys asSet = (Set with: 'FuncCall').
	
	functionCallNode := PSQLASTFunctionCall new.
	
	self
		ensureIdentifier: functionCallNode from: (aDictionary at: 'FuncCall');
		ensureArgumentsList: functionCallNode from: (aDictionary at: 'FuncCall');
		ensureArgumentsDictionary: functionCallNode from: (aDictionary at: 'FuncCall').
		
	^ functionCallNode
]
