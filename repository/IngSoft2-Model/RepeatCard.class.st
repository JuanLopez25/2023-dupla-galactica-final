Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
RepeatCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	aGame isPlaying: anObjective.
	aGame repeatEffectTo: anObjective.
	^ EmptyObject new.
]

{ #category : #information }
RepeatCard >> hasEffect [

	^ true
]

{ #category : #information }
RepeatCard >> isEmpty [

	^ false
]

{ #category : #information }
RepeatCard >> isPermanent [

	^ false
]
