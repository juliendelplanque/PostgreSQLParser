"
I build AST nodes from some of the PostgreSQL tokens.
"
Class {
	#name : #PSQLTokenASTBuilder,
	#superclass : #PSQLTokenizer,
	#category : #PostgreSQL-AST-Builder
}

{ #category : #accessing }
PSQLTokenASTBuilder >> asterik [
	^ super asterik ==> [ :tokens |
		PSQLASTWildCard new ]
]

{ #category : #accessing }
PSQLTokenASTBuilder >> escapeStringConstant [
	^ super escapeStringConstant ==> [ :tokens |
		PSQLASTStringConstant new
			content: (String newFrom: tokens flattened allButFirst allButLast);
			yourself ]
]

{ #category : #helpers }
PSQLTokenASTBuilder >> identifier [
	^ super identifier ==> [ :tokens | 
		PSQLASTIdentifier new
			identifier: tokens second;
			yourself ]
]

{ #category : #accessing }
PSQLTokenASTBuilder >> identifierOrKeyword [
	^ super identifierOrKeyword ==> [ :tokens | String newFrom: tokens flattened ]
]

{ #category : #helpers }
PSQLTokenASTBuilder >> identifierWithOptionalFieldAccess [
	^ super identifierWithOptionalFieldAccess ==> [ :tokens |
		tokens second
			ifNil: [ tokens first ]
			ifNotNil: [ 
				PSQLASTAttributeAccess new
					accessed: tokens first;
					attributeIdentifier: tokens second second;
					yourself ] ]
]

{ #category : #accessing }
PSQLTokenASTBuilder >> numericConstant [
	^ super numericConstant ==> [ :tokens |
		PSQLASTNumericConstant new
			content: (String newFrom: (tokens flattened reject: #isNil));
			yourself ]
]

{ #category : #accessing }
PSQLTokenASTBuilder >> positionalParameter [
	^ super positionalParameter ==> [ :tokens | 
		PSQLPlpgSQLASTPositionalParameter new
			index: (String newFrom: tokens second) asNumber;
			yourself ]
]

{ #category : #accessing }
PSQLTokenASTBuilder >> simpleStringConstant [
	^ super simpleStringConstant ==> [ :tokens |
		PSQLASTStringConstant new
			content: (String newFrom: tokens flattened allButFirst allButLast);
			yourself ]
]
