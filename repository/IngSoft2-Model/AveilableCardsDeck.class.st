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

{ #category : #cards }
AveilableCardsDeck >> addExistingCards: aCard [

	cardsInDeck addLast: aCard
]

{ #category : #cards }
AveilableCardsDeck >> addNewCards: aCardAmount [

	aCardAmount amountOfCards timesRepeat: [ 
		cardsInDeck addLast: aCardAmount cardClass create ].
]

{ #category : #information }
AveilableCardsDeck >> cardsToDeal [

	^ cardsInDeck size
]

{ #category : #cards }
AveilableCardsDeck >> createCardFor: aPlayerColor [

	| selectedCard aRandomValue |
	aRandomValue := cardsInDeck size atRandom.
	selectedCard := cardsInDeck at: aRandomValue.
	selectedCard newHolder: aPlayerColor.
	cardsInDeck remove: selectedCard.
	^ selectedCard
]

{ #category : #initialization }
AveilableCardsDeck >> initializeWith: aCardAmount [

	cardsInDeck := OrderedCollection new.
	aCardAmount amountOfCards timesRepeat: [ 
		cardsInDeck addLast: aCardAmount cardClass create ]
]

{ #category : #information }
AveilableCardsDeck >> isEmpty [

	^ cardsInDeck isEmpty
]
