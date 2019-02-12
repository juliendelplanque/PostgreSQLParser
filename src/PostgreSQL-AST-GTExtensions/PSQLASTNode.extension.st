Extension { #name : #PSQLASTNode }

{ #category : #'*PostgreSQL-AST-GTExtensions' }
PSQLASTNode >> gtNodesIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite tree
		title: 'Tree';
		display: [ :anObject | anObject ];
		children: [ :each | each children ];
		yourself
]

{ #category : #'*PostgreSQL-AST-GTExtensions' }
PSQLASTNode >> gtSourceCodeIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite text
		title: 'Source code';
		display: [ self  ];
		format: [ :t | (self sourceCode
				ifNil: [ 'No source code available' ]
				ifNotNil: [ self sourceCodeAsText ]) ];
		withLineNumbers: true;
		initialize: [ :presentation | 
			(self sourceCode isNil or: [ self startPosition isNil or: [ self endPosition isNil ] ])
				ifFalse: [ 
					presentation selectionInterval: (self startPosition to: self endPosition) ] ];
		yourself
]

{ #category : #'*PostgreSQL-AST-GTExtensions' }
PSQLASTNode >> privateSourceCodeAsText [
	^ self sourceCode asText
]

{ #category : #'*PostgreSQL-AST-GTExtensions' }
PSQLASTNode >> sourceCodeAsText [
	^ self isRoot
		ifTrue: [ self privateSourceCodeAsText ]
		ifFalse: [ self root sourceCodeAsText ]
]
