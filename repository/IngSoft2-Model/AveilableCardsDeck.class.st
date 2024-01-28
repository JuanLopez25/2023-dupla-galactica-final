Class {
	#name : #AveilableCardsDeck,
	#superclass : #Object,
	#instVars : [
		'cardsInDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
AveilableCardsDeck class >> with: aCardAmount [ 
	^self new initializeWith: aCardAmount.
]

{ #category : #Cards }
AveilableCardsDeck >> addExistingCards: aCard [

	cardsInDeck addLast: aCard
]

{ #category : #Cards }
AveilableCardsDeck >> addNewCards: aCardAmount [

	aCardAmount amountOfCards timesRepeat: [ 
		cardsInDeck addLast: aCardAmount cardClass create ].
]

{ #category : #Information }
AveilableCardsDeck >> cardsToDeal [

	^ cardsInDeck size
]

{ #category : #Cards }
AveilableCardsDeck >> createCardFor: aPlayerColor [

	| selectedCard aRandomValue |
	aRandomValue := cardsInDeck size atRandom.
	selectedCard := cardsInDeck at: aRandomValue.
	selectedCard newHolder: aPlayerColor.
	cardsInDeck remove: selectedCard.
	^ selectedCard
]

{ #category : #Initialization }
AveilableCardsDeck >> initializeWith: aCardAmount [

	cardsInDeck := OrderedCollection new.
	aCardAmount amountOfCards timesRepeat: [ 
		cardsInDeck addLast: aCardAmount cardClass create ]
]

{ #category : #Information }
AveilableCardsDeck >> isEmpty [
	^ cardsInDeck isEmpty.
]
