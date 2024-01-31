Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CancellationCard >> = aCard [

	^ aCard class = self class
]

{ #category : #effect }
CancellationCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	cardManager desactivate: anObjective.
	cardManager discard: cardManager beingUse.
]

{ #category : #information }
CancellationCard >> hasEffect [

	^ true
]

{ #category : #information }
CancellationCard >> isEmpty [

	^ false
]

{ #category : #information }
CancellationCard >> isPermanent [

	^ false
]
