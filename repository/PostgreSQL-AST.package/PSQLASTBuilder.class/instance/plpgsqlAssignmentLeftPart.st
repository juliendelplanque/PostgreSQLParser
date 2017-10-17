accessing
plpgsqlAssignmentLeftPart
	^ super plpgsqlAssignmentLeftPart ==> [ :tokens |
			|target|
			target := tokens first.
			tokens second do: [ :subTokens | "First manage attribute access."
				target := PSQLASTAttributeAccess new
								accessed: target;
								attributeIdentifier: subTokens second;
								yourself ].
			tokens third do: [ :subscriptTokens | "Then manage subscripts."
				target := PSQLSubscript new
								target: target;
								subscriptExpression: subscriptTokens second;
								yourself ].
			target ]