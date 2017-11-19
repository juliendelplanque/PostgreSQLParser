Class {
	#name : #BaselineOfPostgreSQL,
	#superclass : #BaselineOf,
	#category : #BaselineOfPostgreSQL
}

{ #category : #baselines }
BaselineOfPostgreSQL >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		self
			definePackages: spec;
			defineDependencies: spec ]
]

{ #category : #baselines }
BaselineOfPostgreSQL >> defineDependencies: spec [
	spec
		project: 'PetitParser' with: [
			spec
				className: 'ConfigurationOfPetitParser';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo50/main' ];
		project: 'PetitParserExtension' with: [
			spec
				className: 'ConfigurationOfPetitParserExtension';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Moose/PetitParserExtensions/main' ]
]

{ #category : #baselines }
BaselineOfPostgreSQL >> definePackages: spec [
	spec 
		package: #'PostgreSQL-Parser' with: [ spec requires: #('PetitParser' 'PetitParserExtension') ];
		package: #'PostgreSQL-Parser-Tests' with: [ spec requires: #('PostgreSQL-Parser') ];
		package: #'PostgreSQL-AST';
		package: #'PostgreSQL-AST-Builder' with: [ spec requires: #('PostgreSQL-AST' 'PostgreSQL-Parser') ];
		package: #'PostgreSQL-AST-Builder-Tests' with: [ spec requires: #('PostgreSQL-AST-Builder') ]
]
