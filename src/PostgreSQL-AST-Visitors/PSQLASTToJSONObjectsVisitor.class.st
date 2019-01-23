"
I convert an AST to a JSON object.

For an AST, the following code returns the JSON object:
[[[
	ast acceptVisitor: PSQLASTToJSONObjectsVisitor new.
]]]
"
Class {
	#name : #PSQLASTToJSONObjectsVisitor,
	#superclass : #PSQLASTReflectiveASTVisitor,
	#category : #'PostgreSQL-AST-Visitors'
}

{ #category : #visiting }
PSQLASTToJSONObjectsVisitor >> visitPSQLASTIdentifier: aPSQLASTIdentifier [
	^ (super visitPSQLASTIdentifier: aPSQLASTIdentifier)
		at: #identifier put: aPSQLASTIdentifier identifier;
		yourself
]

{ #category : #visiting }
PSQLASTToJSONObjectsVisitor >> visitPSQLASTNode: aPSQLASTNode [
	^ { 
		'type' -> aPSQLASTNode classNameWithoutPrefix.
		'isSQL' -> (aPSQLASTNode isKindOf: PSQLPlpgSQLASTNode) not.
		'isPlpgSQL' -> (aPSQLASTNode isKindOf: PSQLPlpgSQLASTNode).
		'startPosition' -> aPSQLASTNode startPosition.
		'endPosition' -> aPSQLASTNode endPosition.
		'children' -> (aPSQLASTNode children collect: [ :child | child acceptVisitor: self ] as: Array)
	} asDictionary
]

{ #category : #visiting }
PSQLASTToJSONObjectsVisitor >> visitPSQLASTNumericConstant: aPSQLASTNumericConstant [
	^ (super visitPSQLASTNumericConstant: aPSQLASTNumericConstant)
		at: #constant put: aPSQLASTNumericConstant content;
		yourself
]

{ #category : #visiting }
PSQLASTToJSONObjectsVisitor >> visitPSQLASTStringConstant: aPSQLASTStringConstant [
	^ (super visitPSQLASTStringConstant: aPSQLASTStringConstant)
		at: #constant put: aPSQLASTStringConstant content;
		yourself
]
