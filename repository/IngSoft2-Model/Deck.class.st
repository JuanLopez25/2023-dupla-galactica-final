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

{ #category : #Card }
Deck >> addCard: aCardAmount [

	cardsInDeck addLast: aCardAmount
]

{ #category : #Information }
Deck >> cardsToDeal [
	^ cardsInDeck sum: [:card| card probability].
]

{ #category : #Cards }
Deck >> createCardFor: aPlayerColor [

	| selectedCard aRandomValue sum |
	sum := 0.
	aRandomValue := (cardsInDeck size) atRandom.
	selectedCard := (cardsInDeck detect: [ :card | 
		   sum := sum + card probability.
		   aRandomValue <= sum ]) cardClass.
	self hasBeenTaken: selectedCard.
	^ selectedCard holder: aPlayerColor.
]

{ #category : #Cards }
Deck >> hasBeenTaken: aCardClass [

	| aSelectedCard |
	aSelectedCard := cardsInDeck detect: [ :card | 
		                 card cardClass = aCardClass ].
	aSelectedCard takeOutOne.
	(aSelectedCard probability = 0) ifTrue: [ cardsInDeck remove: aSelectedCard ]
]

{ #category : #Initialization }
Deck >> initializeWith: aCardAmount [ 
	
	cardsInDeck := OrderedCollection with: aCardAmount .
]

{ #category : #Information }
Deck >> isEmpty [
	^ cardsInDeck isEmpty.
]
