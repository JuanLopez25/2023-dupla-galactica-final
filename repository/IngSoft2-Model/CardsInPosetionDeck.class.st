Class {
	#name : #CardsInPosetionDeck,
	#superclass : #Object,
	#instVars : [
		'playersHands'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardsInPosetionDeck class >> createDeckFor: aColorCollection [

	^ self new initializeDeckFor: aColorCollection
]

{ #category : #'changing cards' }
CardsInPosetionDeck >> addCard: aCard to: aColorPlayer [

	aCard isEmpty ifFalse: [ 
		playersHands
			detect: [ :playerHand | playerHand owner = aColorPlayer ]
			ifFound: [ :hand | hand addCard: aCard ]
			ifNone: [ Error signal: 'That is not a valid objective' ] ]
]

{ #category : #'changing cards' }
CardsInPosetionDeck >> cardsOf: aPlayerColor [

	^ (playersHands detect: [ :hand | hand owner = aPlayerColor ]) size
]

{ #category : #'changing cards' }
CardsInPosetionDeck >> hasBeenGiven: aCard to: aPlayerColor [

	playersHands
		detect: [ :hand | hand owner = aPlayerColor and: [ hand has: aCard ] ]
		ifFound: [ :hand | ^ true ].
	^ false
]

{ #category : #initialization }
CardsInPosetionDeck >> initializeDeckFor: aColorCollection [

	playersHands := OrderedCollection new.
	aColorCollection do: [ :color | playersHands addLast: (PlayerHand of: color) ]
]

{ #category : #initialization }
CardsInPosetionDeck >> takeOut: aCard to: aColorPlayer [

	aCard isEmpty ifFalse: [ 
		(playersHands detect: [ :playerHand | playerHand owner = aColorPlayer ]) 
			takeOut: aCard ]
]
