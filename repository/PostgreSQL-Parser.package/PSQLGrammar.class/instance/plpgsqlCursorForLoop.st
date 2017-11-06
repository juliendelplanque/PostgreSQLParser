plpgsql
plpgsqlCursorForLoop
	"[ <<label>> ]
	FOR recordvar IN bound_cursorvar [ ( [ argument_name := ] argument_value [, ...] ) ] LOOP
   		statements
	END LOOP [ label ]
	"
	self halt: 'TODO'