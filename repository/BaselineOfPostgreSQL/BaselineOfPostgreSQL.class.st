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
		project: 'PetitParser-Gui' with: [
			spec
				className: 'ConfigurationOfPetitParser';
				version: #stable;
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo50/main';
				loads: #('Gui') ];
		baseline: 'LibpgqueryBridge' with: [ 
			spec
				repository: 'github://juliendelplanque/LibpgqueryBridge/repository' ] 
]

{ #category : #baselines }
BaselineOfPostgreSQL >> defineGroups: spec [
	spec
		group: 'parser' with: #('PostgreSQL-Parser');
		group: 'parser-tests' with: #('parser' 'PostgreSQL-Parser-Tests');
		group: 'ast' with: #('PostgreSQL-AST');
		group: 'ast-builder' with: #('ast' 'PostgreSQL-AST-Builder');
		group: 'ast-builder-tests' with: #('ast-builder' 'PostgreSQL-AST-Builder-Tests' 'PostgreSQL-AST-Builder-SmokeTests');
		group: 'core' with: #('parser' 'ast' 'ast-builder');
		group: 'core-tests' with: #('core' 'parser-tests' 'ast-builder-tests');
		group: 'dev' with: #('core-tests' 'PostgreSQL-DevTools')
]

{ #category : #baselines }
BaselineOfPostgreSQL >> definePackages: spec [
	spec 
		package: #'PostgreSQL-Parser' with: [ spec requires: #('PetitParser-Core') ];
		package: #'PostgreSQL-Parser-Tests' with: [ spec requires: #('PetitParser-Tests' 'PostgreSQL-Parser') ];
		package: #'PostgreSQL-AST';
		package: #'PostgreSQL-AST-Builder' with: [ spec requires: #('PostgreSQL-AST' 'PostgreSQL-Parser') ];
		package: #'PostgreSQL-AST-Builder-Tests' with: [ spec requires: #('PostgreSQL-AST-Builder') ];
		package: #'PostgreSQL-AST-Builder-SmokeTests' with: [ spec requires: #('PostgreSQL-AST-Builder' 'PostgreSQL-Parser-Tests') ];
		package: #'PostgreSQL-LibpgQuery' with: [ spec requires: #('LibpgqueryBridge') ];
		package: #'PostgreSQL-DevTools' with: [ spec requires: #('PetitParser-Gui') ]
]
