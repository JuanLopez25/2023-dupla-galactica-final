Class {
	#name : #RandomCardBox,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
RandomCardBox >> effect: aPlayer in: aGame [

	aGame addCardTo: aPlayer.
]
