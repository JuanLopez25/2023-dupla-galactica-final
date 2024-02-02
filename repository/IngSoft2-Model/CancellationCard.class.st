Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CancellationCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #effect }
CancellationCard >> applyCardUsing: cardManager at: aGame to: anObjective of: aHolder [

	cardManager desactivate: anObjective of: aHolder.
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
