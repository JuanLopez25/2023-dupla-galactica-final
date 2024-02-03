Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
SpeedCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #effect }
SpeedCard >> effect [

	^ 1
]

{ #category : #information }
SpeedCard >> hasEffect [

	^ true
]

{ #category : #information }
SpeedCard >> isEmpty [

	^ false
]

{ #category : #information }
SpeedCard >> isPermanent [

	^ true
]

{ #category : #effect }
SpeedCard >> objectiveWhenTarget: anObjective using: aCardManager [

	anObjective = EveryPlayer new
		ifFalse: [ ^ anObjective ]
		ifTrue: [ ^ EmptyObject new ]
]
