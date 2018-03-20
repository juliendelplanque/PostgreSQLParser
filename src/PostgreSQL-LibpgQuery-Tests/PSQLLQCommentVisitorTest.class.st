"
A PSQLLQCommentVisitorTest is a test class for testing the behavior of PSQLLQCommentVisitor
"
Class {
	#name : #PSQLLQCommentVisitorTest,
	#superclass : #TestCase,
	#category : #PostgreSQL-LibpgQuery-Tests
}

{ #category : #samples }
PSQLLQCommentVisitorTest >> sampleDict1 [
	^ Dictionary new
		add: 'objtype' -> 40;
		add:
			'objname'
				->
					((Array new: 1)
						at: 1
							put:
							(Dictionary new
								add:
									'TypeName'
										->
											(Dictionary new
												add: 'names' -> #('notify_level');
												add: 'location' -> 16;
												add: 'typemod' -> -1;
												yourself);
								yourself);
						yourself);
		add:
			'comment'
				->
					'Level of notification: ''none'' = no notifications, ''voting'' = notifications about finished issues and issues in voting, ''verification'' = notifications about finished issues, issues in voting and verification phase, ''discussion'' = notifications about everything except issues in admission phase, ''all'' = notifications about everything';
		yourself
]

{ #category : #samples }
PSQLLQCommentVisitorTest >> sampleDict2 [
	^ Dictionary new
		add: 'objtype' -> 5;
		add: 'objname' -> #('member' 'last_delegation_check');
		add: 'comment' -> 'Timestamp of last delegation check (i.e. confirmation of all unit and area delegations)';
		yourself
]

{ #category : #tests-visiting }
PSQLLQCommentVisitorTest >> testVisitDictionary [
	| result |
	result := self sampleDict1 psqlJSONAccept: PSQLLQCommentVisitor new.
	
	self
		assert: result class equals: PSQLASTLQComment;
		assert: result comment equals: 'Level of notification: ''none'' = no notifications, ''voting'' = notifications about finished issues and issues in voting, ''verification'' = notifications about finished issues, issues in voting and verification phase, ''discussion'' = notifications about everything except issues in admission phase, ''all'' = notifications about everything';
		assert: result target class equals: PSQLASTIdentifier;
		assert: result target identifier equals: 'notify_level'.
		
	result := self sampleDict2 psqlJSONAccept: PSQLLQCommentVisitor new.
	
	self
		assert: result class equals: PSQLASTLQComment;
		assert: result comment equals: 'Timestamp of last delegation check (i.e. confirmation of all unit and area delegations)';
		assert: result target class equals: PSQLASTAttributeAccess;
		assert: result target accessed class equals: PSQLASTIdentifier;
		assert: result target accessed identifier equals: 'member';
		assert: result target attributeIdentifier class equals: PSQLASTIdentifier;
		assert: result target attributeIdentifier identifier equals: 'last_delegation_check'
]
