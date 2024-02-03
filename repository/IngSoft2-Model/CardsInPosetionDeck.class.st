Class {
	#name : #CardsInPosetionDeck,
	#superclass : #Object,
	#instVars : [
		'playersHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardsInPosetionDeck class >> createFor: aColorCollection [

	^ self new initializeCreateFor: aColorCollection
]

{ #category : #cards }
CardsInPosetionDeck >> addCard: aCard to: aColorPlayer [

	playersHands
		detect: [ :hand | hand holder = aColorPlayer ]
		ifFound: [ :hand | hand addCard: aCard ]
]

{ #category : #cards }
CardsInPosetionDeck >> cardsOf: aPlayerColor [

	^ (playersHands detect: [ :hand | hand holder = aPlayerColor ]) cards size
]

{ #category : #cards }
CardsInPosetionDeck >> hasBeenGiven: aCard to: aPlayerColor [

	playersHands
		detect: [ :posetionCard | posetionCard holder = aPlayerColor]
		ifFound: [ :posetionCard | ^  posetionCard has: aCard ].
	^ false
]

{ #category : #initialization }
CardsInPosetionDeck >> initializeCreateFor: aColorCollection [

	playersHands := OrderedCollection new.
	aColorCollection do: [ :color | 
		playersHands addLast: (PlayerPosetionCards with: EmptyObject new of: color) ]
]

{ #category : #initialization }
CardsInPosetionDeck >> takeOut: aCard to: aColorPlayer [

	playersHands
		detect: [ :posetionCard | posetionCard holder = aColorPlayer ]
		ifFound: [ :posetionCard | posetionCard takeOut: aCard ]
]
