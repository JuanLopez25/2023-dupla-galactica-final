Class {
	#name : #CardsInPosetionDeck,
	#superclass : #Object,
	#instVars : [
		'posetionsCards'
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
		posetionsCards addLast: (PosetionCard with: aCard of: aColorPlayer)]
]

{ #category : #cards }
CardsInPosetionDeck >> cardsOf: aPlayerColor [

	^ (posetionsCards select: [ :posetionCard | posetionCard holder = aPlayerColor ]) size
]

{ #category : #cards }
CardsInPosetionDeck >> hasBeenGiven: aCard to: aPlayerColor [

	posetionsCards
		detect: [ :posetionCard |( posetionCard holder = aPlayerColor) and: (posetionCard card = aCard) ]
		ifFound: [ :hand | ^ true ].
	^ false
]

{ #category : #initialization }
CardsInPosetionDeck >> initializeCreate [

	posetionsCards := OrderedCollection new.
]

{ #category : #initialization }
CardsInPosetionDeck >> takeOut: aCard to: aColorPlayer [

	posetionsCards remove: (posetionsCards detect: [ :posetionCard | 
			 posetionCard card = aCard and: posetionCard holder = aColorPlayer ])
]
