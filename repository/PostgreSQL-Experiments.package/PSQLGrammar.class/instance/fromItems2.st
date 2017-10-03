select command
fromItems2
	"( select ) [ AS ] alias [ ( column_alias [, ...] ) ]"
	^ openParenthesis trim , selectCommand , closeParenthesis trim , as trim optional ,
			alias trim ,
			(openParenthesis trim,
			 (columnAlias separatedBy: comma trim),
			 closeParenthesis trim) optional