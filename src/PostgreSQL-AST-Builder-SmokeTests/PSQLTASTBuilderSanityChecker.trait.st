"
Override #parse:rule: method to do sanity checks on the ASTs built.

Basically:

- Checks that each node has its #startPosition and #endPosition not nil
- Checks that each node has its parent set after calling #setChildrenParent
- Checks that each node object is kind of PSQLASTNode.
"
Trait {
	#name : #PSQLTASTBuilderSanityChecker,
	#category : #'PostgreSQL-AST-Builder-SmokeTests'
}

{ #category : #checking }
PSQLTASTBuilderSanityChecker >> checkEachNodeHasItsPositionsSet: ast [
	self
		assert:
			(ast
				breadthFirstSelect: [ :node | node startPosition isNil or: [ node endPosition isNil ] ])
				size
		equals: 0
]

{ #category : #checking }
PSQLTASTBuilderSanityChecker >> checkEachNodeHasParentExceptRoot: ast [
	ast breadthFirstDetect: [ :node |
		node parent isNil and: [ node ~= ast ] ] ifFound: [ self fail ]
]

{ #category : #checking }
PSQLTASTBuilderSanityChecker >> checkEachNodeIsKindOfPSQLASTNode: ast [
	ast
		breadthFirstDetect: [ :n | (n isKindOf: PSQLASTNode) not ]
		ifFound: [ self fail ]
]

{ #category : #parsing }
PSQLTASTBuilderSanityChecker >> parse: aString rule: aSymbol [
	| ast |
	ast := super parse: aString rule: aSymbol.
	ast
		setChildrenParent;
		sourceCode: aString.
	self checkEachNodeIsKindOfPSQLASTNode: ast.
	self checkEachNodeHasItsPositionsSet: ast.
	self checkEachNodeHasParentExceptRoot: ast
]
