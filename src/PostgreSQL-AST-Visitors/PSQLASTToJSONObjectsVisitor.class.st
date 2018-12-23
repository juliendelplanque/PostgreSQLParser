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
