gt-inspector-extension
gtDisplayTokensOn: composite
	<gtInspectorPresentationOrder: 0>  
	^ (composite list)
		title: 'Tokens';
		display: [ :aCollection | self tokensWithoutWhitespaces ];
		yourself