Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
OverloadCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #effect }
OverloadCard >> effect [

	^ -2
]

{ #category : #information }
OverloadCard >> hasEffect [

	^ true
]

{ #category : #information }
OverloadCard >> isEmpty [

	^ false
]

{ #category : #information }
OverloadCard >> isPermanent [

	^ true
]

{ #category : #effect }
OverloadCard >> objectiveWhenTarget: anObjective using: aCardManager [

	anObjective = EveryPlayer new ifFalse: [ ^ anObjective ] ifTrue: [ ^ EmptyObject new ]
]
