Class {
	#name : #DiscardsCards,
	#superclass : #Object,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
DiscardsCards class >> createDeck [
	^ self new intializeCreateDeck.
]

{ #category : #Cards }
DiscardsCards >> addCard: aCard [ 
	
	deck addLast: aCard.
]

{ #category : #Information }
DiscardsCards >> deckSize [

	^ deck size.
]

{ #category : #Initialization }
DiscardsCards >> intializeCreateDeck [
	
	deck := OrderedCollection new.
]

{ #category : #Card }
DiscardsCards >> shuffle [

	| aNewDeck |
	deck isEmpty ifTrue: [ ^ OrderedCollection new ].
	aNewDeck := OrderedCollection new.

	deck do: [ :card | 
		aNewDeck
			detect: [ :cardAmount | cardAmount cardClass = card class ]
			ifFound: [ :cardAmount | cardAmount addOne ]
			ifNone: [ 
			aNewDeck addLast: (CardProbability using: card class withChance: 1) ] ].
	^aNewDeck.
]
