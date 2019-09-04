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
			(ast breadthFirstIterator
				select: [ :node | node startPosition isNil or: [ node endPosition isNil ] ])
				isEmpty
		description: 'Sanity check failed: #startPosition and #endPosition should not be nil in any node of the AST.'
]

{ #category : #checking }
PSQLTASTBuilderSanityChecker >> checkEachNodeHasParentExceptRoot: ast [
	ast breadthFirstIterator
		detect: [ :node |
		node parent isNil and: [ node ~= ast ] ] ifFound: [ self fail:  'Sanity check failed: all node of the AST should have its parent set.' ]
]

{ #category : #checking }
PSQLTASTBuilderSanityChecker >> checkEachNodeIsKindOfPSQLASTNode: ast [
	ast breadthFirstIterator
		detect: [ :n | (n isKindOf: PSQLASTNode) not ]
		ifFound: [ self fail: 'Sanity check failed: All node of the AST should be kind of PSQLASTNode.' ]
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
	self checkEachNodeHasParentExceptRoot: ast.
	^ ast
]
