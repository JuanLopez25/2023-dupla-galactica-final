Class {
	#name : #RandomCardBox,
	#superclass : #Object,
	#instVars : [
		'cardsAmount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #creation }
RandomCardBox >> duplicate [

	^ self class new
]

{ #category : #effect }
RandomCardBox >> effect: aPlayer in: aGame [

	aGame addCardTo: aPlayer.
]
