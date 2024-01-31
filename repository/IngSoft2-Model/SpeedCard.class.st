Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
SpeedCard >> = aCard [

	^ aCard class = self class
]

{ #category : #effect }
SpeedCard >> applyCardUsing: cardManager at: aGame to: anObjective [

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
