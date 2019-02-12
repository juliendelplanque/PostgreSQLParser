Class {
	#name : #BaselineOfPostgreSQLParser,
	#superclass : #BaselineOf,
	#category : #BaselineOfPostgreSQLParser
}

{ #category : #baselines }
BaselineOfPostgreSQLParser >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		self
			definePackages: spec;
			defineDependencies: spec;
			defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfPostgreSQLParser >> defineDependencies: spec [
	spec
		baseline: 'PetitParser' with: [
			spec
				loads: #('Core' 'Preprocessor');
				repository: 'github://moosetechnology/PetitParser/src' ];
		project: 'PetitParser-Gui' copyFrom: 'PetitParser' with: [ spec loads: #('GT') ];
		project: 'PetitParser-Highlighter' copyFrom: 'PetitParser' with: [ spec loads: #('Highlighter') ];
		baseline: 'LibpgqueryBridge' with: [ 
			spec
				repository: 'github://juliendelplanque/LibpgqueryBridge/repository' ];
		baseline: 'TreeQuery' with: [
			spec
				repository: 'github://juliendelplanque/TreeQuery/src' ]
]

{ #category : #baselines }
BaselineOfPostgreSQLParser >> defineGroups: spec [
	spec
		group: 'parser' with: #('PostgreSQL-Parser');
		group: 'parser-tests' with: #('parser' 'PostgreSQL-Parser-Tests');
		group: 'ast' with: #('PostgreSQL-AST');
		group: 'ast-tests' with: #('ast' 'PostgreSQL-AST-Tests');
		group: 'ast-builder' with: #('ast' 'PostgreSQL-AST-Builder');
		group: 'ast-builder-tests' with: #('ast-builder' 'ast-tests' 'PostgreSQL-AST-Builder-Tests' 'PostgreSQL-AST-Builder-SmokeTests');
		group: 'visitors' with: #('ast' 'PostgreSQL-AST-Visitors');
		group: 'facade' with: #('PostgreSQL-Facade');
		group: 'core' with: #('parser' 'ast' 'ast-builder' 'visitors' 'facade' 'PostgreSQL-AST-GTExtensions');
		group: 'core-tests' with: #('core' 'parser-tests' 'ast-builder-tests');
		group: 'future' with: #('core-tests' 'PostgreSQL-Future');
		group: 'dev' with: #('core-tests' 'PostgreSQL-DevTools' 'PostgreSQL-AST-GTExtensions' 'future')
]

{ #category : #baselines }
BaselineOfPostgreSQLParser >> definePackages: spec [
	spec 
		package: #'PostgreSQL-Parser' with: [ spec requires: #('PetitParser') ];
		package: #'PostgreSQL-Parser-Tests' with: [ spec requires: #('PetitParser' 'PostgreSQL-Parser') ];
		package: #'PostgreSQL-Parser-CrashTests' with: [ spec requires: #('PostgreSQL-Parser-Tests') ];
		package: #'PostgreSQL-AST' with: [ spec requires: #('TreeQuery') ];
		package: #'PostgreSQL-AST-Tests' with: [ spec requires: #('PostgreSQL-AST') ];
		package: #'PostgreSQL-AST-GTExtensions' with: [ spec requires: #('PostgreSQL-AST' 'PostgreSQL-Highlighter') ];
		package: #'PostgreSQL-AST-Builder' with: [ spec requires: #('PostgreSQL-AST' 'PostgreSQL-Parser') ];
		package: #'PostgreSQL-AST-Builder-Tests' with: [ spec requires: #('PostgreSQL-Parser-Tests' 'PostgreSQL-AST-Builder') ];
		package: #'PostgreSQL-AST-Builder-SmokeTests' with: [ spec requires: #('PostgreSQL-Parser-CrashTests') ];
		package: #'PostgreSQL-AST-Visitors' with: [ spec requires: #('PostgreSQL-AST') ];
		package: #'PostgreSQL-Facade' with: [ spec requires: #('PostgreSQL-Parser' 'PostgreSQL-AST-Builder') ];
		package: #'PostgreSQL-Highlighter' with: [ spec requires: #('PostgreSQL-Parser' 'PetitParser-Highlighter') ];
		package: #'PostgreSQL-LibpgQuery' with: [ spec requires: #('LibpgqueryBridge') ];
		package: #'PostgreSQL-Future' with: [ spec requires: #('PostgreSQL-Parser' 'PostgreSQL-Parser-Tests') ];
		package: #'PostgreSQL-DevTools' with: [ spec requires: #('PetitParser-Gui') ]
]
