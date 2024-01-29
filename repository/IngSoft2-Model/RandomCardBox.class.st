Class {
	#name : #RandomCardBox,
	#superclass : #Object,
	#instVars : [
		'cardsAmount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
RandomCardBox class >> dealing: cardsProbabilities [ 

	^ self new intializeDealing: cardsProbabilities.
]

{ #category : #effect }
RandomCardBox >> effect: aGame [

	aGame addAmountOfCards: cardsAmount.
]

{ #category : #initialization }
RandomCardBox >> intializeDealing: anAmountOfCards [

	cardsAmount := anAmountOfCards
]
