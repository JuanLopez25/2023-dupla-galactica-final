Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
AccelerationCard >> applyCardUsing: cardManager at: aGame to: anObjectiveCard [

	^ EveryPlayer new.
]

{ #category : #effect }
AccelerationCard >> applyEffect [

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
