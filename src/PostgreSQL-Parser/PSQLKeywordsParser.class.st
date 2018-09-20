"
I am a parser for the keywords of PostgreSQL.
"
Class {
	#name : #PSQLKeywordsParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'is',
		'inner',
		'else',
		'left',
		'view',
		'isnull',
		'nulls',
		'strict',
		'trueKeyword',
		'info',
		'when',
		'recursive',
		'no',
		'first',
		'declare',
		'with',
		'limit',
		'in',
		'endKeyword',
		'set',
		'exit',
		'only',
		'ordinality',
		'elsif',
		'distinct',
		'group',
		'nowait',
		'create',
		'constantKeyword',
		'natural',
		'notnull',
		'execute',
		'perform',
		'from',
		'slice',
		'union',
		'assert',
		'using',
		'forward',
		'lateral',
		'exception',
		'fetch',
		'case',
		'offset',
		'do',
		'outer',
		'prior',
		'rows',
		'having',
		'if',
		'null',
		'unlogged',
		'array',
		'get',
		'or',
		'for',
		'table',
		'query',
		'asc',
		'move',
		'on',
		'foreach',
		'warning',
		'share',
		'select',
		'current',
		'andKeyword',
		'nothing',
		'last',
		'begin',
		'between',
		'notKeyword',
		'keyword',
		'notice',
		'desc',
		'delete',
		'right',
		'row',
		'symmetric',
		'intersect',
		'relative',
		'by',
		'debug',
		'absolute',
		'record',
		'returning',
		'temp',
		'temporary',
		'conflict',
		'as',
		'cursor',
		'unknown',
		'whereKeyword',
		'loop',
		'while',
		'update',
		'constraint',
		'full',
		'insert',
		'join',
		'continue',
		'all',
		'into',
		'scroll',
		'falseKeyword',
		'then',
		'reverse',
		'collate',
		'open',
		'next',
		'backward',
		'cross',
		'default',
		'close',
		'any',
		'replace',
		'values',
		'log',
		'except',
		'diagnostics',
		'of',
		'order',
		'raise',
		'return',
		'cast'
	],
	#category : #'PostgreSQL-Parser-Core'
}

{ #category : #keywords }
PSQLKeywordsParser >> absolute [
	<psqlkeyword>
	^ self buildKeyword: 'absolute'
]

{ #category : #keywords }
PSQLKeywordsParser >> all [
	<psqlkeyword>
	^ self buildKeyword: 'all'
]

{ #category : #keywords }
PSQLKeywordsParser >> andKeyword [
	<psqlkeyword>
	^ self buildKeyword: 'and'
]

{ #category : #keywords }
PSQLKeywordsParser >> any [
	<psqlkeyword>
	^ self buildKeyword: 'any'
]

{ #category : #keywords }
PSQLKeywordsParser >> array [
	<psqlkeyword>
	^ self buildKeyword: 'array'
]

{ #category : #keywords }
PSQLKeywordsParser >> as [
	<psqlkeyword>
	^ self buildKeyword: 'as'
]

{ #category : #keywords }
PSQLKeywordsParser >> asc [
	<psqlkeyword>
	^ self buildKeyword: 'asc'
]

{ #category : #keywords }
PSQLKeywordsParser >> assert [
	<psqlkeyword>
	^ self buildKeyword: 'assert'
]

{ #category : #keywords }
PSQLKeywordsParser >> backward [
	<psqlkeyword>
	^ self buildKeyword: 'backward'
]

{ #category : #keywords }
PSQLKeywordsParser >> begin [
	<psqlkeyword>
	^ self buildKeyword: 'begin'
]

{ #category : #keywords }
PSQLKeywordsParser >> between [
	<psqlkeyword>
	^ self buildKeyword: 'between'
]

{ #category : #'keyword building' }
PSQLKeywordsParser >> buildKeyword: aString [
	^ aString asParser caseInsensitive
]

{ #category : #keywords }
PSQLKeywordsParser >> by [
	<psqlkeyword>
	^ self buildKeyword: 'by'
]

{ #category : #keywords }
PSQLKeywordsParser >> case [
	<psqlkeyword>
	^ self buildKeyword: 'case'
]

{ #category : #keywords }
PSQLKeywordsParser >> cast [
	<psqlkeyword>
	^ self buildKeyword: 'cast'
]

{ #category : #keywords }
PSQLKeywordsParser >> close [
	<psqlkeyword>
	^ self buildKeyword: 'close'
]

{ #category : #keywords }
PSQLKeywordsParser >> collate [
	<psqlkeyword>
	^ self buildKeyword: 'collate'
]

{ #category : #keywords }
PSQLKeywordsParser >> commit [
	<psqlkeyword>
	^ self buildKeyword: 'commit'
]

{ #category : #keywords }
PSQLKeywordsParser >> conflict [
	<psqlkeyword>
	^ self buildKeyword: 'conflict'
]

{ #category : #keywords }
PSQLKeywordsParser >> constantKeyword [
	<psqlkeyword>
	^ self buildKeyword: 'constant'
]

{ #category : #keywords }
PSQLKeywordsParser >> constraint [
	<psqlkeyword>
	^ self buildKeyword: 'constraint'
]

{ #category : #keywords }
PSQLKeywordsParser >> continue [
	<psqlkeyword>
	^ self buildKeyword: 'continue'
]

{ #category : #keywords }
PSQLKeywordsParser >> create [
	<psqlkeyword>
	^ self buildKeyword: 'create'
]

{ #category : #keywords }
PSQLKeywordsParser >> cross [
	<psqlkeyword>
	^ self buildKeyword: 'cross'
]

{ #category : #keywords }
PSQLKeywordsParser >> current [
	<psqlkeyword>
	^ self buildKeyword: 'current'
]

{ #category : #keywords }
PSQLKeywordsParser >> cursor [
	<psqlkeyword>
	^ self buildKeyword: 'cursor'
]

{ #category : #keywords }
PSQLKeywordsParser >> debug [
	^ self buildKeyword: 'debug'
]

{ #category : #keywords }
PSQLKeywordsParser >> declare [
	<psqlkeyword>
	^ self buildKeyword: 'declare'
]

{ #category : #keywords }
PSQLKeywordsParser >> default [
	<psqlkeyword>
	^ self buildKeyword: 'default'
]

{ #category : #keywords }
PSQLKeywordsParser >> delete [
	<psqlkeyword>
	^ self buildKeyword: 'delete'
]

{ #category : #keywords }
PSQLKeywordsParser >> desc [
	<psqlkeyword>
	^ self buildKeyword: 'desc'
]

{ #category : #keywords }
PSQLKeywordsParser >> diagnostics [
	<psqlkeyword>
	^ self buildKeyword: 'diagnostics'
]

{ #category : #keywords }
PSQLKeywordsParser >> distinct [
	<psqlkeyword>
	^ self buildKeyword: 'distinct'
]

{ #category : #keywords }
PSQLKeywordsParser >> do [
	<psqlkeyword>
	^ self buildKeyword: 'do'
]

{ #category : #keywords }
PSQLKeywordsParser >> else [
	<psqlkeyword>
	^ self buildKeyword: 'else'
]

{ #category : #keywords }
PSQLKeywordsParser >> elsif [
	<psqlkeyword>
	^ self buildKeyword: 'elsif'
]

{ #category : #keywords }
PSQLKeywordsParser >> endKeyword [
	<psqlkeyword>
	^ self buildKeyword: 'end'
]

{ #category : #keywords }
PSQLKeywordsParser >> except [
	<psqlkeyword>
	^ self buildKeyword: 'except'
]

{ #category : #keywords }
PSQLKeywordsParser >> exception [
	<psqlkeyword>
	^ self buildKeyword: 'exception'
]

{ #category : #keywords }
PSQLKeywordsParser >> execute [
	<psqlkeyword>
	^ self buildKeyword: 'execute'
]

{ #category : #keywords }
PSQLKeywordsParser >> exists [

	^ self buildKeyword: 'exists'
]

{ #category : #keywords }
PSQLKeywordsParser >> exit [
	<psqlkeyword>
	^ self buildKeyword: 'exit'
]

{ #category : #keywords }
PSQLKeywordsParser >> falseKeyword [
	"<psqlkeyword>"
	^ self buildKeyword: 'false'
]

{ #category : #keywords }
PSQLKeywordsParser >> fetch [
	<psqlkeyword>
	^ self buildKeyword: 'fetch'
]

{ #category : #keywords }
PSQLKeywordsParser >> first [
	<psqlkeyword>
	^ self buildKeyword: 'first'
]

{ #category : #keywords }
PSQLKeywordsParser >> for [
	<psqlkeyword>
	^ self buildKeyword: 'for'
]

{ #category : #keywords }
PSQLKeywordsParser >> foreach [
	<psqlkeyword>
	^ self buildKeyword: 'foreach'
]

{ #category : #keywords }
PSQLKeywordsParser >> forward [
	<psqlkeyword>
	^ self buildKeyword: 'forward'
]

{ #category : #keywords }
PSQLKeywordsParser >> from [
	<psqlkeyword>
	^ self buildKeyword: 'from'
]

{ #category : #keywords }
PSQLKeywordsParser >> full [
	<psqlkeyword>
	^ self buildKeyword: 'full'
]

{ #category : #keywords }
PSQLKeywordsParser >> get [
	<psqlkeyword>
	^ self buildKeyword: 'get'
]

{ #category : #keywords }
PSQLKeywordsParser >> global [
	<psqlkeyword>
	^ self buildKeyword: 'global'
]

{ #category : #keywords }
PSQLKeywordsParser >> group [
	<psqlkeyword>
	^ self buildKeyword: 'group'
]

{ #category : #keywords }
PSQLKeywordsParser >> having [
	<psqlkeyword>
	^ self buildKeyword: 'having'
]

{ #category : #keywords }
PSQLKeywordsParser >> if [
	<psqlkeyword>
	^ self buildKeyword: 'if'
]

{ #category : #keywords }
PSQLKeywordsParser >> in [
	<psqlkeyword>
	^ self buildKeyword: 'in'
]

{ #category : #keywords }
PSQLKeywordsParser >> info [
	^ self buildKeyword: 'info'
]

{ #category : #keywords }
PSQLKeywordsParser >> inherits [
	<psqlkeyword>
	^ self buildKeyword: 'inherits'
]

{ #category : #keywords }
PSQLKeywordsParser >> inner [
	<psqlkeyword>
	^ self buildKeyword: 'inner'
]

{ #category : #keywords }
PSQLKeywordsParser >> insert [
	<psqlkeyword>
	^ self buildKeyword: 'insert'
]

{ #category : #keywords }
PSQLKeywordsParser >> intersect [
	<psqlkeyword>
	^ self buildKeyword: 'intersect'
]

{ #category : #keywords }
PSQLKeywordsParser >> into [
	<psqlkeyword>
	^ self buildKeyword: 'into'
]

{ #category : #keywords }
PSQLKeywordsParser >> is [
	<psqlkeyword>
	^ self buildKeyword: 'is'
]

{ #category : #keywords }
PSQLKeywordsParser >> isnull [
	<psqlkeyword>
	^ self buildKeyword: 'isnull'
]

{ #category : #keywords }
PSQLKeywordsParser >> join [
	<psqlkeyword>
	^ self buildKeyword: 'join'
]

{ #category : #keywords }
PSQLKeywordsParser >> keyword [
	^ ((Pragma allNamed: #psqlkeyword in: PSQLKeywordsParser)
		collect: [ :pragma | (pragma methodSelector value: self) , #space asParser ])
		fold: [ :k1 :k2 | k1 / k2 ]
]

{ #category : #keywords }
PSQLKeywordsParser >> last [
	<psqlkeyword>
	^ self buildKeyword: 'last'
]

{ #category : #keywords }
PSQLKeywordsParser >> lateral [
	<psqlkeyword>
	^ self buildKeyword: 'lateral'
]

{ #category : #keywords }
PSQLKeywordsParser >> left [
	<psqlkeyword>
	^ self buildKeyword: 'left'
]

{ #category : #keywords }
PSQLKeywordsParser >> limit [
	<psqlkeyword>
	^ self buildKeyword: 'limit'
]

{ #category : #keywords }
PSQLKeywordsParser >> local [
	<psqlkeyword>
	^ self buildKeyword: 'local'
]

{ #category : #keywords }
PSQLKeywordsParser >> log [
	^ self buildKeyword: 'log'
]

{ #category : #keywords }
PSQLKeywordsParser >> loop [
	<psqlkeyword>
	^ self buildKeyword: 'loop'
]

{ #category : #keywords }
PSQLKeywordsParser >> move [
	<psqlkeyword>
	^ self buildKeyword: 'move'
]

{ #category : #keywords }
PSQLKeywordsParser >> natural [
	<psqlkeyword>
	^ self buildKeyword: 'natural'
]

{ #category : #keywords }
PSQLKeywordsParser >> next [
	<psqlkeyword>
	^ self buildKeyword: 'next'
]

{ #category : #keywords }
PSQLKeywordsParser >> no [
	<psqlkeyword>
	^ self buildKeyword: 'no'
]

{ #category : #keywords }
PSQLKeywordsParser >> notKeyword [
	"Message name with Keyword prefix to avoid clash with super class message #not."
	<psqlkeyword>
	^ self buildKeyword: 'not'
]

{ #category : #keywords }
PSQLKeywordsParser >> nothing [
	<psqlkeyword>
	^ self buildKeyword: 'nothing'
]

{ #category : #keywords }
PSQLKeywordsParser >> notice [
	^ self buildKeyword: 'notice'
]

{ #category : #keywords }
PSQLKeywordsParser >> notnull [
	<psqlkeyword>
	^ self buildKeyword: 'notnull'
]

{ #category : #keywords }
PSQLKeywordsParser >> nowait [
	<psqlkeyword>
	^ self buildKeyword: 'nowait'
]

{ #category : #keywords }
PSQLKeywordsParser >> null [
	<psqlkeyword>
	^ self buildKeyword: 'null'
]

{ #category : #keywords }
PSQLKeywordsParser >> nulls [
	<psqlkeyword>
	^ self buildKeyword: 'nulls'
]

{ #category : #keywords }
PSQLKeywordsParser >> of [
	<psqlkeyword>
	^ self buildKeyword: 'of'
]

{ #category : #keywords }
PSQLKeywordsParser >> offset [
	<psqlkeyword>
	^ self buildKeyword: 'offset'
]

{ #category : #keywords }
PSQLKeywordsParser >> on [
	<psqlkeyword>
	^ self buildKeyword: 'on'
]

{ #category : #keywords }
PSQLKeywordsParser >> only [
	<psqlkeyword>
	^ self buildKeyword: 'only'
]

{ #category : #keywords }
PSQLKeywordsParser >> open [
	<psqlkeyword>
	^ self buildKeyword: 'open'
]

{ #category : #keywords }
PSQLKeywordsParser >> or [
	<psqlkeyword>
	^ self buildKeyword: 'or'
]

{ #category : #keywords }
PSQLKeywordsParser >> order [
	<psqlkeyword>
	^ self buildKeyword: 'order'
]

{ #category : #keywords }
PSQLKeywordsParser >> ordinality [
	<psqlkeyword>
	^ self buildKeyword: 'ordinality'
]

{ #category : #keywords }
PSQLKeywordsParser >> outer [
	<psqlkeyword>
	^ self buildKeyword: 'outer'
]

{ #category : #keywords }
PSQLKeywordsParser >> perform [
	<psqlkeyword>
	^ self buildKeyword: 'perform'
]

{ #category : #keywords }
PSQLKeywordsParser >> prior [
	"<psqlkeyword>" "Apparently, this can be used as an identifier as well..."
	^ self buildKeyword: 'prior'
]

{ #category : #keywords }
PSQLKeywordsParser >> query [
	<psqlkeyword>
	^ self buildKeyword: 'query'
]

{ #category : #keywords }
PSQLKeywordsParser >> raise [
	<psqlkeyword>
	^ self buildKeyword: 'raise'
]

{ #category : #keywords }
PSQLKeywordsParser >> record [
	<psqlkeyword>
	^ self buildKeyword: 'record'
]

{ #category : #keywords }
PSQLKeywordsParser >> recursive [
	<psqlkeyword>
	^ self buildKeyword: 'recursive'
]

{ #category : #keywords }
PSQLKeywordsParser >> relative [
	<psqlkeyword>
	^ self buildKeyword: 'relative'
]

{ #category : #keywords }
PSQLKeywordsParser >> replace [
	<psqlkeyword>
	^ self buildKeyword: 'replace'
]

{ #category : #keywords }
PSQLKeywordsParser >> return [
	<psqlkeyword>
	^ self buildKeyword: 'return'
]

{ #category : #keywords }
PSQLKeywordsParser >> returning [
	<psqlkeyword>
	^ self buildKeyword: 'returning'
]

{ #category : #keywords }
PSQLKeywordsParser >> reverse [
	<psqlkeyword>
	^ self buildKeyword: 'reverse'
]

{ #category : #keywords }
PSQLKeywordsParser >> right [
	<psqlkeyword>
	^ self buildKeyword: 'right'
]

{ #category : #keywords }
PSQLKeywordsParser >> row [
	<psqlkeyword>
	^ self buildKeyword: 'row'
]

{ #category : #keywords }
PSQLKeywordsParser >> rows [
	<psqlkeyword>
	^ self buildKeyword: 'rows'
]

{ #category : #keywords }
PSQLKeywordsParser >> scroll [
	<psqlkeyword>
	^ self buildKeyword: 'scroll'
]

{ #category : #keywords }
PSQLKeywordsParser >> select [
	<psqlkeyword>
	^ self buildKeyword: 'select'
]

{ #category : #keywords }
PSQLKeywordsParser >> set [
	<psqlkeyword>
	^ self buildKeyword: 'set'
]

{ #category : #keywords }
PSQLKeywordsParser >> share [
	<psqlkeyword>
	^ self buildKeyword: 'share'
]

{ #category : #keywords }
PSQLKeywordsParser >> slice [
	<psqlkeyword>
	^ self buildKeyword: 'slice'
]

{ #category : #accessing }
PSQLKeywordsParser >> start [
	"This method as to be implemented but we don't care what it returns since this parser is not meant to be used alone."
	^ PPFailingParser new
]

{ #category : #keywords }
PSQLKeywordsParser >> strict [
	<psqlkeyword>
	^ self buildKeyword: 'strict'
]

{ #category : #keywords }
PSQLKeywordsParser >> symmetric [
	<psqlkeyword>
	^ self buildKeyword: 'symmetric'
]

{ #category : #keywords }
PSQLKeywordsParser >> table [
	^ self buildKeyword: 'table'
]

{ #category : #keywords }
PSQLKeywordsParser >> tablespace [
	<psqlkeyword>
	^ self buildKeyword: 'tablespace'
]

{ #category : #keywords }
PSQLKeywordsParser >> temp [
	<psqlkeyword>
	^ self buildKeyword: 'temp'
]

{ #category : #keywords }
PSQLKeywordsParser >> temporary [
	<psqlkeyword>
	^ self buildKeyword: 'temporary'
]

{ #category : #keywords }
PSQLKeywordsParser >> then [
	<psqlkeyword>
	^ self buildKeyword: 'then'
]

{ #category : #keywords }
PSQLKeywordsParser >> trueKeyword [
	"<psqlkeyword>"
	^ self buildKeyword: 'true'
]

{ #category : #keywords }
PSQLKeywordsParser >> union [
	<psqlkeyword>
	^ self buildKeyword: 'union'
]

{ #category : #keywords }
PSQLKeywordsParser >> unknown [
	<psqlkeyword>
	^ self buildKeyword: 'unknown'
]

{ #category : #keywords }
PSQLKeywordsParser >> unlogged [
	<psqlkeyword>
	^ self buildKeyword: 'unlogged'
]

{ #category : #keywords }
PSQLKeywordsParser >> update [
	<psqlkeyword>
	^ self buildKeyword: 'update'
]

{ #category : #keywords }
PSQLKeywordsParser >> using [
	<psqlkeyword>
	^ self buildKeyword: 'using'
]

{ #category : #keywords }
PSQLKeywordsParser >> values [
	<psqlkeyword>
	^ self buildKeyword: 'values'
]

{ #category : #keywords }
PSQLKeywordsParser >> view [
	<psqlkeyword>
	^ self buildKeyword: 'view'
]

{ #category : #keywords }
PSQLKeywordsParser >> warning [
	^ self buildKeyword: 'warning'
]

{ #category : #keywords }
PSQLKeywordsParser >> when [
	<psqlkeyword>
	^ self buildKeyword: 'when'
]

{ #category : #keywords }
PSQLKeywordsParser >> whereKeyword [
	<psqlkeyword>
	^ self buildKeyword: 'where'
]

{ #category : #keywords }
PSQLKeywordsParser >> while [
	<psqlkeyword>
	^ self buildKeyword: 'while'
]

{ #category : #keywords }
PSQLKeywordsParser >> with [
	<psqlkeyword>
	^ self buildKeyword: 'with'
]
