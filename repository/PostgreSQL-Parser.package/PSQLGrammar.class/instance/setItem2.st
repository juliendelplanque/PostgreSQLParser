shared
setItem2
	"( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] )"
	^ openParenthesis trim , (columnName plus separatedBy: comma trim) trim , closeParenthesis trim ,
	$= asParser trim ,
	openParenthesis trim , ((kw default / expression) plus separatedBy: comma trim) , closeParenthesis