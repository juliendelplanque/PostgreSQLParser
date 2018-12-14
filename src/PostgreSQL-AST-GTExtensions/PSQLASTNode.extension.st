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
