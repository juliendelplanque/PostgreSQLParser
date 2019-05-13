"
I parse PostgreSQL INSERT/SELECT/UPDATE/DELETE queries.
"
Class {
	#name : #PSQLCRUDQueryGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'insertCommand',
		'selectCommand',
		'updateCommand',
		'deleteCommand'
	],
	#category : #'PostgreSQL-Parser-Grammars-CRUD'
}

{ #category : #accessing }
PSQLCRUDQueryGrammar class >> deleteQueryParser [
	^ PSQLDeleteQueryGrammar
]

{ #category : #accessing }
PSQLCRUDQueryGrammar class >> dependencies [
	^ { self selectQueryParser . self insertQueryParser . self updateQueryParser . self deleteQueryParser }
]

{ #category : #accessing }
PSQLCRUDQueryGrammar class >> insertQueryParser [
	^ PSQLInsertQueryGrammar
]

{ #category : #accessing }
PSQLCRUDQueryGrammar class >> selectQueryParser [
	^ PSQLSelectQueryGrammar
]

{ #category : #accessing }
PSQLCRUDQueryGrammar class >> startSymbol [
	^ #startEnd
]

{ #category : #accessing }
PSQLCRUDQueryGrammar class >> updateQueryParser [
	^ PSQLUpdateQueryGrammar
]

{ #category : #dependencies }
PSQLCRUDQueryGrammar >> deleteCommand [
	^ (self dependencyAt: self class deleteQueryParser) deleteCommand
]

{ #category : #dependencies }
PSQLCRUDQueryGrammar >> insertCommand [
	^ (self dependencyAt: self class insertQueryParser) insertCommand
]

{ #category : #dependencies }
PSQLCRUDQueryGrammar >> selectCommand [
	^ (self dependencyAt: self class selectQueryParser) selectIntoCommand / (self dependencyAt: self class selectQueryParser) selectCommand
]

{ #category : #accessing }
PSQLCRUDQueryGrammar >> start [
	^ insertCommand / selectCommand / updateCommand / deleteCommand
]

{ #category : #accessing }
PSQLCRUDQueryGrammar >> startEnd [
	^ self start end
]

{ #category : #dependencies }
PSQLCRUDQueryGrammar >> updateCommand [
	^ (self dependencyAt: self class updateQueryParser) updateCommand
]
