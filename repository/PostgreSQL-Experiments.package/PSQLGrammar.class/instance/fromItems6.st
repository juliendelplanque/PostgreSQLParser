select command
fromItems6
	"from_item [ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]"
	^ fromItems trim , natural trim optional , joinType trim , fromItems trim , 
		((on trim , expression) / 
		(using trim ,
			openParenthesis trim , 
			(columnReference separatedBy: comma trim),
			closeParenthesis trim)) optional