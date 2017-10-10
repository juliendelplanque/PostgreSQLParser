plpgsql
plpgsqlCompositeValue
	^ openParenthesis trim , (expression plus separatedBy: comma trim) , closeParenthesis trim , typeCastConstruct trim optional