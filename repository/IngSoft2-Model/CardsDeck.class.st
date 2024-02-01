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

	anAmount timesRepeat: [ cardsInDeck addLast: aCardClass deepCopy ]
]

{ #category : #information }
CardsDeck >> cardsToDeal [

	^ cardsInDeck size
]

{ #category : #cards }
CardsDeck >> dealCard [

	| selectedCard |
	selectedCard := cardsInDeck at: 1.
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

{ #category : #information }
CardsDeck >> shuffle [

	| aNewDeck aRandomValue selectedCard |
	aNewDeck := OrderedCollection new.
	cardsInDeck size timesRepeat: [ 
		aRandomValue := cardsInDeck size atRandom.
		selectedCard := cardsInDeck at: aRandomValue.
		cardsInDeck remove: selectedCard.
		aNewDeck addLast: selectedCard ].
	cardsInDeck := OrderedCollection new.
	^ aNewDeck
]
