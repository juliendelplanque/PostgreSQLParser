accessing
hexBitStringConstant
	^ ($x asParser / $X asParser) , $' asParser ,
	(#letter asParser/#digit asParser) star,
	$' asParser