accessing
binaryBitStringConstant
	^ ($b asParser / $B asParser) , $' asParser ,
	($0 asParser / $1 asParser) star,
	$' asParser