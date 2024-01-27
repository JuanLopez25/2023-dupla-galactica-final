Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardsInDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
Deck class >> with: aCardAmount [ 
	^self new initializeWith: aCardAmount.
]

{ #category : #Cards }
Deck >> addExistingCards: aCard [

	aCard holder: (EmptyPlayer new).
	cardsInDeck addLast: aCard
]

{ #category : #Cards }
Deck >> addNewCards: aCardAmount [

	aCardAmount amountOfCards timesRepeat: [ 
		cardsInDeck addLast: aCardAmount cardClass create ].
]

{ #category : #Information }
Deck >> cardsToDeal [
	^ cardsInDeck size.
]

{ #category : #Cards }
Deck >> createCardFor: aPlayerColor [

	| selectedCard aRandomValue |
	aRandomValue := cardsInDeck size atRandom.
	selectedCard := cardsInDeck at: aRandomValue.
	selectedCard holder: aPlayerColor.
	cardsInDeck remove: selectedCard.
	^ selectedCard
]

{ #category : #Initialization }
Deck >> initializeWith: aCardAmount [

	cardsInDeck := OrderedCollection new.
	aCardAmount amountOfCards timesRepeat: [ 
		cardsInDeck addLast: aCardAmount cardClass create ]
]

{ #category : #Information }
Deck >> isEmpty [
	^ cardsInDeck isEmpty.
]
