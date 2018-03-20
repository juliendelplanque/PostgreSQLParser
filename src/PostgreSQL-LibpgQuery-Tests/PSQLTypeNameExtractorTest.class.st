"
A PSQLTypeNameExtractorTest is a test class for testing the behavior of PSQLTypeNameExtractor
"
Class {
	#name : #PSQLTypeNameExtractorTest,
	#superclass : #TestCase,
	#category : #PostgreSQL-LibpgQuery-Tests
}

{ #category : #samples }
PSQLTypeNameExtractorTest >> sampleDict1 [
	^ Dictionary new
		add:
			'TypeName'
				->
					(Dictionary new
						add: 'names' -> #('tsquery');
						add: 'location' -> 474;
						add: 'typemod' -> -1;
						yourself);
		yourself
]

{ #category : #samples }
PSQLTypeNameExtractorTest >> sampleDict2 [
	^ Dictionary new
		add:
			'TypeName'
				->
					(Dictionary new
						add: 'names' -> #('notify_level');
						add: 'location' -> 16;
						add: 'typemod' -> -1;
						yourself);
		yourself
]

{ #category : #tests }
PSQLTypeNameExtractorTest >> testVisitDictionary [
	| result |
	result := self sampleDict1 psqlJSONAccept: PSQLTypeNameExtractor new.
	
	self
		assert: result class equals: PSQLASTIdentifier;
		assert: result identifier equals: 'tsquery'.
	
	result := self sampleDict2 psqlJSONAccept: PSQLTypeNameExtractor new.
	
	self 
		assert: result class equals: PSQLASTIdentifier;
		assert: result identifier equals: 'notify_level'
]
