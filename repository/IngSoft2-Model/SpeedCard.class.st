Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	aGame isPlaying: anObjective.
	^ anObjective
]

{ #category : #effect }
SpeedCard >> applyEffect [

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
