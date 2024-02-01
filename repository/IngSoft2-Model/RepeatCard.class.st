Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RepeatCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #effect }
RepeatCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	
	aGame repeatEffectTo: anObjective.
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
