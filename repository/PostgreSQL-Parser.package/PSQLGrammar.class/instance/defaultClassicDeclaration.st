as yet unclassified
defaultClassicDeclaration
	^ identifier trim ,
	kw constantKeyword trim optional ,
	plpgsqlDeclarationType ,
	plpgsqlDeclarationCollate optional ,
	(kw notKeyword trim , kw null trim) optional ,
	((kw default trim / ':=' asParser trim / $= asParser trim) , expression) optional