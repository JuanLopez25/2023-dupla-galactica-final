Class {
	#name : #SprintBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SprintBox >> effect: aPlayer in: aGame [

	aGame move: aPlayer amount: (aGame cardsInPosetionOf: aPlayer color)
]
