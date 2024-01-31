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

	anObjective = EveryPlayer new ifFalse: [ 
		cardManager beingUse hasEffect
			ifTrue: [ cardManager active: self to: anObjective ]
			ifFalse: [ 
			cardManager active: cardManager beingUse to: anObjective ] ]
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
