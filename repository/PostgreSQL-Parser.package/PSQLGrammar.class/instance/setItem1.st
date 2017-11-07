shared
setItem1
	"column_name = { expression | DEFAULT }"
	^ columnName trim , $= asParser trim , (kw default / expression)