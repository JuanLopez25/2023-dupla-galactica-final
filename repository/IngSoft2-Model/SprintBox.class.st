Class {
	#name : #SprintBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
SprintBox >> duplicate [

	^ self class new
]

{ #category : #effect }
SprintBox >> effect: aPlayer in: aGame [

	aGame move: aPlayer amount: (aGame cardsInPosetionOf: aPlayer color)
]
