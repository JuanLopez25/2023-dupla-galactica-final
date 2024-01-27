Class {
	#name : #CardDealer,
	#superclass : #Object,
	#instVars : [
		'deck',
		'discardDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardDealer class >> with: aDeck [ 

	^ self new intializeWith: aDeck.
]

{ #category : #Information }
CardDealer >> cardsToDeal [

	^ deck cardsToDeal
]

{ #category : #Cards }
CardDealer >> createCardFor: aColor [

	| aNewDeck |
	deck isEmpty ifTrue: [ 
		aNewDeck := discardDeck shuffle.
		aNewDeck do: [ :card | deck addExistingCards: card ].
		deck isEmpty ifTrue: [ ^ EmptyCard new ] ].
	^ deck createCardFor: aColor
]

{ #category : #Cards }
CardDealer >> discard: aCard [

	discardDeck addCard: aCard
]

{ #category : #Information }
CardDealer >> discardCardsDeskAmount [

	^ discardDeck deckSize
]

{ #category : #Initialization }
CardDealer >> intializeWith: aDeck [

	deck := aDeck.
	discardDeck := DiscardsCards createDeck.
]
