shared
setItem3
	"( column_name [, ...] ) = ( sub-SELECT )"
	^ openParenthesis trim , (columnName plus separatedBy: comma trim) , closeParenthesis trim ,
	$= asParser trim ,
	openParenthesis trim , selectCommand trim , closeParenthesis trim