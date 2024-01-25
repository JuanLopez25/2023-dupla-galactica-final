Class {
	#name : #SprintBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #Effect }
SprintBox >> effect: aGame [

	aGame moveCurrent: (aGame cardsInPosetionOf: aGame currentPlayer)
]
