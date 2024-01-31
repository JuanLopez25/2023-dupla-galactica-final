Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'cardsInDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDeck class >> create [

	^ self new initializeCreate
]

{ #category : #cards }
LoadedDeck >> addCard: aCard amount: anAmount [

	anAmount timesRepeat: [ 
		cardsInDeck addLast: aCard new ].
]

{ #category : #initialization }
LoadedDeck >> dealCard [

	| selectedCard |
	selectedCard := cardsInDeck at: 1.
	cardsInDeck remove: selectedCard.
	^ selectedCard
]

{ #category : #initialization }
LoadedDeck >> initializeCreate [

	cardsInDeck := OrderedCollection new.
]

{ #category : #information }
LoadedDeck >> isEmpty [

	^ cardsInDeck isEmpty
]
