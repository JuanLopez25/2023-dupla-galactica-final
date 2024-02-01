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

	anAmount timesRepeat: [ cardsInDeck addLast: aCard deepCopy ]
]

{ #category : #cards }
LoadedDeck >> cardsToDeal [

	^cardsInDeck size
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

{ #category : #cards }
LoadedDeck >> shuffle [

	|newDeck|
	newDeck := cardsInDeck.
	cardsInDeck := OrderedCollection new.
	^ newDeck
]
