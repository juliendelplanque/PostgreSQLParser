accessing
fetchClause
	^ kw fetch trim , (kw first trim / kw next trim) , numericConstant trim optional , (kw rows trim / kw row trim) , kw only trim