Class {
	#name : #CardsInPosetionDeck,
	#superclass : #Object,
	#instVars : [
		'playersHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardsInPosetionDeck class >> create [

	^ self new initializeCreate
]

{ #category : #cards }
CardsInPosetionDeck >> addCard: aCard to: aColorPlayer [

	aCard isEmpty ifFalse: [ 
		playersHands addLast: (PosetionCard with: aCard of: aColorPlayer)]
]

{ #category : #cards }
CardsInPosetionDeck >> cardsOf: aPlayerColor [

	^ (playersHands select: [ :posetionCard | posetionCard holder = aPlayerColor ]) size
]

{ #category : #cards }
CardsInPosetionDeck >> hasBeenGiven: aCard to: aPlayerColor [

	playersHands
		detect: [ :posetionCard |( posetionCard holder = aPlayerColor) and: (posetionCard card = aCard) ]
		ifFound: [ :hand | ^ true ].
	^ false
]

{ #category : #initialization }
CardsInPosetionDeck >> initializeCreate [

	playersHands := OrderedCollection new.
]

{ #category : #initialization }
CardsInPosetionDeck >> takeOut: aCard to: aColorPlayer [

	aCard isEmpty ifFalse: [ 
		playersHands remove: (playersHands detect: [ :posetionCard | 
				 posetionCard card = aCard and: posetionCard holder = aColorPlayer ]) ]
]
