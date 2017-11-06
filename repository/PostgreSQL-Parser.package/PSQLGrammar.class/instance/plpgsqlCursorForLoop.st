plpgsql
plpgsqlCursorForLoop
	"[ <<label>> ]
	FOR recordvar IN bound_cursorvar [ ( [ argument_name := ] argument_value [, ...] ) ] LOOP
   		statements
	END LOOP [ label ]
	"
	^ plpgsqlBeginLabel trim optional ,
	kw for trim , identifier trim , kw in trim , identifier trim ,
	(openParenthesis trim ,
		(((identifier trim , ':=' asParser) trim optional , expression trim) plus separatedBy: comma trim) ,
	closeParenthesis trim) optional ,
	kw loop trim ,
	plpgsqlStatements ,
	kw endKeyword trim , kw loop trim , plpgsqlEndLabel trim optional