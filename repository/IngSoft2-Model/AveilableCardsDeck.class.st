Class {
	#name : #AveilableCardsDeck,
	#superclass : #Object,
	#instVars : [
		'cardsInDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AveilableCardsDeck class >> create [

	^ self new initializeCreate.
]

{ #category : #cards }
AveilableCardsDeck >> addCard: aCardClass amount: anAmount [

	aCardClass new isEmpty ifFalse: [ 
		anAmount timesRepeat: [ cardsInDeck addLast: aCardClass new ] ]
]

{ #category : #information }
AveilableCardsDeck >> cardsToDeal [

	^ cardsInDeck size
]

{ #category : #cards }
AveilableCardsDeck >> dealCard [

	| selectedCard aRandomValue |
	aRandomValue := cardsInDeck size atRandom.
	selectedCard := cardsInDeck at: aRandomValue.
	cardsInDeck remove: selectedCard.
	^ selectedCard
]

{ #category : #initialization }
AveilableCardsDeck >> initializeCreate [

	cardsInDeck := OrderedCollection new.
]

{ #category : #information }
AveilableCardsDeck >> isEmpty [

	^ cardsInDeck isEmpty
]
