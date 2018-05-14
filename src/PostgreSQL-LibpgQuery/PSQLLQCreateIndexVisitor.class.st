Class {
	#name : #PSQLLQCreateIndexVisitor,
	#superclass : #PSQLJSONVisitor,
	#category : #'PostgreSQL-LibpgQuery-Visitors'
}

{ #category : #visiting }
PSQLLQCreateIndexVisitor >> ensureIdentifier: createIndexNode from: aDictionary [
	createIndexNode
		identifier: (PSQLASTIdentifier new
							identifier: (aDictionary at: 'idxname');
							yourself)
]

{ #category : #visiting }
PSQLLQCreateIndexVisitor >> ensureIndexParameters: createIndexNode from: aDictionary [
	| columnName |
	self assert: (aDictionary at: 'indexParams') size = 1.
	self halt.
	"columnName := ((aDictionary at: 'indexParams') first at: 'IndexElem') at: 'name'.
	
	createIndexNode
		column: (PSQLASTIdentifier new
					identifier: columnName;
					yourself)"
]

{ #category : #visiting }
PSQLLQCreateIndexVisitor >> ensureTable: createIndexNode from: aDictionary [
	createIndexNode
		table: (PSQLASTIdentifier new
					identifier: (((aDictionary at: 'relation') at: 'RangeVar') at: 'relname');
					yourself)
]

{ #category : #visiting }
PSQLLQCreateIndexVisitor >> visitDictionary: aDictionary [
	| createIndexNode |
	createIndexNode := PSQLASTLQCreateIndex new.
	
	self
		ensureIdentifier: createIndexNode from: aDictionary;
		ensureTable: createIndexNode from: aDictionary;
		ensureIndexParameters: createIndexNode from: aDictionary.
		
	^ createIndexNode
]
