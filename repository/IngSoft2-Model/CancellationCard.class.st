Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
CancellationCard >> applyCardUsing: cardManager at: aGame to: anObjectiveCard [

	cardManager desactivate: anObjectiveCard.
	^ EmptyObject new.
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
