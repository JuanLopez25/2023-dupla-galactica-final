Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
OverloadCard >> = aCard [

	^ aCard class = self class
]

{ #category : #effect }
OverloadCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	anObjective = EveryPlayer new ifFalse: [ 
		cardManager beingUse hasEffect
			ifTrue: [ cardManager active: self to: anObjective ]
			ifFalse: [ 
			cardManager active: cardManager beingUse to: anObjective ] ]
]

{ #category : #effect }
OverloadCard >> applyEffect [

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
