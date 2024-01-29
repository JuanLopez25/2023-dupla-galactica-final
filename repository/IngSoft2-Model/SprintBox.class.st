Class {
	#name : #SprintBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SprintBox >> effect: aGame [

	aGame moveCurrent: (aGame cardsInPosetionOf: aGame currentPlayer)
]
