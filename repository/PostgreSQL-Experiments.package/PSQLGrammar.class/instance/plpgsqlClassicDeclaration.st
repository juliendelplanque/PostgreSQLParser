plpgsql
plpgsqlClassicDeclaration
	^ identifier trim ,
	constantKeyword trim optional ,
	plpgsqlDeclarationType ,
	plpgsqlDeclarationCollate optional ,
	(notKeyword trim , null trim) optional ,
	((default trim / ':=' asParser trim / $= asParser trim) , expression) optional