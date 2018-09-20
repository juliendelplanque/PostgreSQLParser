"
I represent an experiment related to magic constants.

One should provide me a file reference of a directory containing a directory named 'raw' containing zero or all these files (each file is a text file, 1 query/line)
	- 'select-queries.txt'
	- 'insert-queries.txt'
	- 'update-queries.txt'
	- 'delete-queries.txt'

"
Class {
	#name : #PSQLMagicConstantsExperiment,
	#superclass : #Object,
	#instVars : [
		'directory',
		'normalizeBlock'
	],
	#category : #'PostgreSQL-AST-SelectQueryAnalysis'
}

{ #category : #accessing }
PSQLMagicConstantsExperiment class >> deleteQueriesFileName [
	^ 'delete-queries.txt'
]

{ #category : #accessing }
PSQLMagicConstantsExperiment class >> insertQueriesFileName [
	^ 'insert-queries.txt'
]

{ #category : #experiments }
PSQLMagicConstantsExperiment class >> oscarExperiment [
	^ PSQLMagicConstantsExperiment new
		directory: '/Users/julien/Documents/GIT/Papers/2019-MagicNumbersInDB/Experiments/QueriesAnalysis/dataset/OSCAR' asFileReference;
		normalizeBlock: [ :queryString |
			(queryString splitOn: '"?\$\{[^}]+\}"?' asRegex) joinUsing: '__magic_analysis_replaced_var__' ]
		yourself
]

{ #category : #accessing }
PSQLMagicConstantsExperiment class >> selectQueriesFileName [
	^ 'select-queries.txt'
]

{ #category : #accessing }
PSQLMagicConstantsExperiment class >> updateQueriesFileName [
	^ 'update-queries.txt'
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> allQueriesFileNames [
	^ { self selectQueriesFileName . self insertQueriesFileName . self updateQueriesFileName . self deleteQueriesFileName }
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> deleteQueriesFileName [
	^ self class deleteQueriesFileName
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> directory [
	^ directory
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> directory: anObject [
	directory := anObject
]

{ #category : #initialization }
PSQLMagicConstantsExperiment >> initialize [
	super initialize.
	self normalizeBlock: [ :queryString | queryString ]
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> insertQueriesFileName [
	^ self class insertQueriesFileName
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> normalizeBlock [
	^ normalizeBlock
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> normalizeBlock: anObject [
	normalizeBlock := anObject
]

{ #category : #normalizing }
PSQLMagicConstantsExperiment >> normalizeData [
	self normalizedDirectory
		ensureCreateDirectory.
	
	self rawDataFiles do: [ :file |
		(self normalizedDirectory / file basename)
			ensureDelete;
			writeStreamDo: [ :s |
				file contents lines do: [ :queryString |
					s
						<< (self normalizeQuery: queryString);
						<< Smalltalk os lineEnding ] ] ]
]

{ #category : #normalizing }
PSQLMagicConstantsExperiment >> normalizeQuery: queryString [
	"By default does nothing, just return the queryString.
	 To override if some treatment needs to be done."
	^ self normalizeBlock value: queryString
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> normalizedDirectory [
	^ self directory / 'normalized'
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> rawDataFiles [
	^ self rawDirectory childrenMatching: (self allQueriesFileNames joinUsing: $;)
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> rawDirectory [
	^ self directory / 'raw'
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> selectQueriesFileName [
	^ self class selectQueriesFileName
]

{ #category : #accessing }
PSQLMagicConstantsExperiment >> updateQueriesFileName [
	^ self class updateQueriesFileName
]
