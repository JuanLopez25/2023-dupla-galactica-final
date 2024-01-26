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

{ #category : #Effect }
RandomCardBox >> effect: aGame [

	aGame addAmountOfCards: cardsAmount.
]

{ #category : #Initialization }
RandomCardBox >> intializeDealing: anAmountOfCards [

	cardsAmount := anAmountOfCards
]
