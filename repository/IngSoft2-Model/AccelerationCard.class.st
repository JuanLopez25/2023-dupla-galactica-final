Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
AccelerationCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #effect }
AccelerationCard >> effect [

	^ 1
]

{ #category : #information }
AccelerationCard >> hasEffect [

	^ true
]

{ #category : #information }
AccelerationCard >> isEmpty [

	^ false
]

{ #category : #information }
AccelerationCard >> isPermanent [

	^ true
]

{ #category : #information }
AccelerationCard >> objectiveWhenTarget: anObjective using: aCardManager [

	^ EveryPlayer new
]
