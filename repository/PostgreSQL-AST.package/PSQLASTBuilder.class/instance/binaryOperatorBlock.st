accessing - blocks
binaryOperatorBlock
	^ [ :exp1 :op :exp2 |
			PSQLASTBinaryOperator new
				operator: op;
				left: exp1;
				right: exp2;
				yourself ]