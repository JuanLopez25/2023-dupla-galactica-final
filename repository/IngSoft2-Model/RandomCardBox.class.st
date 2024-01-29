Class {
	#name : #RandomCardBox,
	#superclass : #Object,
	#instVars : [
		'cardsAmount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
RandomCardBox >> effect: aGame [

	aGame addCardToCurrent.
]
