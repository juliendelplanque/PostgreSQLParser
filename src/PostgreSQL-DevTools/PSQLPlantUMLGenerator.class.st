Class {
	#name : #PSQLPlantUMLGenerator,
	#superclass : #Object,
	#category : #'PostgreSQL-DevTools'
}

{ #category : #'plant uml' }
PSQLPlantUMLGenerator class >> parserDependenciesPlantUMLScript [
	| classes relations |
	classes := PPCompositeParser allSubclasses select: [ :c | c name beginsWith: 'PSQL' ].
relations := (classes collect: [ :c | c dependencies collect: [ :dep | c -> dep ] ]) flattened.

	^ String streamContents: [ :s |
	s << '@startuml
skinparam class {
	BackgroundColor White
	ArrowColor Black
	BorderColor Black
}

''skinparam linetype ortho
skinparam classFontSize 22

hide empty members
hide circle';
	lf.
	classes do: [ :c |
		s
			<< 'class ';
			<< c name;
			lf ].
	
	relations do: [ :assoc |
		s
			<< assoc key name;
			<< ' --|> ';
			<< assoc value name;
			lf ].
	s << '@enduml' ]
]
