Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
OverloadCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	^ anObjective.
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
