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
		display: [ self sourceCode asText ];
		initialize: [ :presentation | 
			presentation selectionInterval: (self startPosition to: self endPosition) ];
		yourself
]
