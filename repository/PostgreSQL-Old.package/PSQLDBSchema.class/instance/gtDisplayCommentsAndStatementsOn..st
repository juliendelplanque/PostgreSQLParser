gt-inspector-extension
gtDisplayCommentsAndStatementsOn: composite
	<gtInspectorPresentationOrder: 0>  
	^ (composite list)
		title: 'Comments and statements';
		display: [ :aCollection | self commentsAndStatements ];
		yourself