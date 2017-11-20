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
			defineDependencies: spec;
			defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfPostgreSQL >> defineDependencies: spec [
	spec
		project: 'PetitParser-Core' with: [
			spec
				className: 'ConfigurationOfPetitParser';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo50/main';
				loads: #('Core') ];
		project: 'PetitParser-Tests' with: [
			spec
				className: 'ConfigurationOfPetitParser';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo50/main';
				loads: #('Tests') ];
		project: 'PetitParserExtension' with: [
			spec
				className: 'ConfigurationOfPetitParserExtension';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Moose/PetitParserExtensions/main' ]
]

{ #category : #baselines }
BaselineOfPostgreSQL >> defineGroups: spec [
	spec
		group: 'parser' with: #('PostgreSQL-Parser');
		group: 'parser-tests' with: #('parser' 'PostgreSQL-Parser-Tests');
		group: 'ast' with: #('PostgreSQL-AST');
		group: 'ast-builder' with: #('ast' 'PostgreSQL-AST-Builder');
		group: 'ast-builder-tests' with: #('ast-builder' 'PostgreSQL-AST-Builder-Tests');
		group: 'core' with: #('parser' 'ast' 'ast-builder');
		group: 'core-tests' with: #('core' 'parser-tests' 'ast-builder-tests')
]

{ #category : #baselines }
BaselineOfPostgreSQL >> definePackages: spec [
	spec 
		package: #'PostgreSQL-Parser' with: [ spec requires: #('PetitParser-Core' 'PetitParserExtension') ];
		package: #'PostgreSQL-Parser-Tests' with: [ spec requires: #('PetitParser-Tests' 'PostgreSQL-Parser') ];
		package: #'PostgreSQL-AST';
		package: #'PostgreSQL-AST-Builder' with: [ spec requires: #('PostgreSQL-AST' 'PostgreSQL-Parser') ];
		package: #'PostgreSQL-AST-Builder-Tests' with: [ spec requires: #('PostgreSQL-AST-Builder') ]
]
