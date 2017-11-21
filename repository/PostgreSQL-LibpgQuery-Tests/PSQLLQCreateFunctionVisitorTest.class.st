"
A PSQLLQCreateFunctionVisitorTest is a test class for testing the behavior of PSQLLQCreateFunctionVisitor
"
Class {
	#name : #PSQLLQCreateFunctionVisitorTest,
	#superclass : #TestCase,
	#category : #PostgreSQL-LibpgQuery-Tests
}

{ #category : #samples }
PSQLLQCreateFunctionVisitorTest >> sampleDict1 [
	^ Dictionary new
		add:
			'funcname'
				->
					((Array new: 1)
						at: 1
							put:
							(Dictionary new
								add:
									'String'
										->
											(Dictionary new
												add: 'str' -> 'text_search_query';
												yourself);
								yourself);
						yourself);
		add:
			'returnType'
				->
					(Dictionary new
						add:
							'TypeName'
								->
									(Dictionary new
										add: 'typemod' -> -1;
										add: 'location' -> 474;
										add:
											'names'
												->
													((Array new: 1)
														at: 1
															put:
															(Dictionary new
																add:
																	'String'
																		->
																			(Dictionary new
																				add: 'str' -> 'tsquery';
																				yourself);
																yourself);
														yourself);
										yourself);
						yourself);
		add:
			'options'
				->
					((Array new: 3)
						at: 1
							put:
							(Dictionary new
								add:
									'DefElem'
										->
											(Dictionary new
												add: 'defaction' -> 0;
												add: 'defname' -> 'language';
												add:
													'arg'
														->
															(Dictionary new
																add:
																	'String'
																		->
																			(Dictionary new
																				add: 'str' -> 'plpgsql';
																				yourself);
																yourself);
												add: 'location' -> -1;
												yourself);
								yourself);
						at: 2
							put:
							(Dictionary new
								add:
									'DefElem'
										->
											(Dictionary new
												add: 'defaction' -> 0;
												add: 'defname' -> 'volatility';
												add:
													'arg'
														->
															(Dictionary new
																add:
																	'String'
																		->
																			(Dictionary new
																				add: 'str' -> 'immutable';
																				yourself);
																yourself);
												add: 'location' -> -1;
												yourself);
								yourself);
						at: 3
							put:
							(Dictionary new
								add:
									'DefElem'
										->
											(Dictionary new
												add: 'defaction' -> 0;
												add: 'defname' -> 'as';
												add:
													'arg'
														->
															((Array new: 1)
																at: 1
																	put:
																	(Dictionary new
																		add:
																			'String'
																				->
																					(Dictionary new
																						add: 'str' -> '
    BEGIN
      RETURN plainto_tsquery(''pg_catalog.simple'', "query_text_p");
    END;
  ';
																						yourself);
																		yourself);
																yourself);
												add: 'location' -> -1;
												yourself);
								yourself);
						yourself);
		add:
			'parameters'
				->
					((Array new: 1)
						at: 1
							put:
							(Dictionary new
								add:
									'FunctionParameter'
										->
											(Dictionary new
												add: 'name' -> 'query_text_p';
												add: 'mode' -> 105;
												add:
													'argType'
														->
															(Dictionary new
																add:
																	'TypeName'
																		->
																			(Dictionary new
																				add: 'typemod' -> -1;
																				add: 'location' -> 458;
																				add:
																					'names'
																						->
																							((Array new: 1)
																								at: 1
																									put:
																									(Dictionary new
																										add:
																											'String'
																												->
																													(Dictionary new
																														add: 'str' -> 'text';
																														yourself);
																										yourself);
																								yourself);
																				yourself);
																yourself);
												yourself);
								yourself);
						yourself);
		yourself
]

{ #category : #tests-visiting }
PSQLLQCreateFunctionVisitorTest >> testVisitDictionary [
	| result |
	result := self sampleDict1 psqlJSONAccept: PSQLLQCreateFunctionVisitor new.
	
	self
		assert: result class equals: PSQLASTLQCreateFunction;
		assert: result identifier class equals: PSQLASTIdentifier;
		assert: result identifier identifier equals: 'text_search_query';
		assert: result language class equals: PSQLASTIdentifier;
		assert: result language identifier equals: 'plpgsql';
		assert: result returnType class equals: PSQLASTIdentifier;
		assert: result returnType identifier equals: 'tsquery';
		assert: result body class equals: PSQLPlpgSQLASTBlock;
		assert: result parameters class equals: Array;
		assert: result parameters size equals: 1;
		assert: result parameters first class equals: PSQLASTLQFunctionParameter;
		assert: result parameters first identifier class equals: PSQLASTIdentifier;
		assert: result parameters first identifier identifier equals: 'query_text_p';
		assert: result parameters first typeIdentifier class equals: PSQLASTIdentifier;
		assert: result parameters first typeIdentifier identifier equals: 'text'
]
