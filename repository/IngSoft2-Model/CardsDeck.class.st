Class {
	#name : #CardsDeck,
	#superclass : #Object,
	#instVars : [
		'cardsInDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardsDeck class >> create [

	^ self new initializeCreate.
]

{ #category : #cards }
CardsDeck >> addCard: aCardClass amount: anAmount [

	anAmount timesRepeat: [ cardsInDeck addLast: aCardClass class new ]
]

{ #category : #information }
CardsDeck >> cards [

	| aNewDeck |
	aNewDeck := cardsInDeck.
	cardsInDeck := OrderedCollection new.
	^ aNewDeck
]

{ #category : #information }
CardsDeck >> cardsToDeal [

	^ cardsInDeck size
]

{ #category : #cards }
CardsDeck >> dealCard [

	| selectedCard aRandomValue |
	aRandomValue := cardsInDeck size atRandom.
	selectedCard := cardsInDeck at: aRandomValue.
	cardsInDeck remove: selectedCard.
	^ selectedCard
]

{ #category : #initialization }
CardsDeck >> initializeCreate [

	cardsInDeck := OrderedCollection new.
]

{ #category : #information }
CardsDeck >> isEmpty [

	^ cardsInDeck isEmpty
]
