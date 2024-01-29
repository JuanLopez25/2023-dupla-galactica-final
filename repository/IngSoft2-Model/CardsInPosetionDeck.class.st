Class {
	#name : #CardsInPosetionDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardsInPosetionDeck class >> createDeck [
	^ self new initializeDeck.
]

{ #category : #'changing cards' }
CardsInPosetionDeck >> addCard: aCard [

	(aCard isEmpty) ifFalse: [ cards addLast: aCard ].
]

{ #category : #'changing cards' }
CardsInPosetionDeck >> cardsOf: aPlayerColor [

	^ (cards select: [ :card | card holder = aPlayerColor ]) size
]

{ #category : #'changing cards' }
CardsInPosetionDeck >> hasBeenGiven: aCard [

	cards
		detect: [ :card | card sameHolder: aCard ]
		ifFound: [ :card | ^ true ]
		ifNone: [ ^ false ]
]

{ #category : #initialization }
CardsInPosetionDeck >> initializeDeck [

	cards := OrderedCollection new
]

{ #category : #initialization }
CardsInPosetionDeck >> takeOut: aCard [

	cards
		detect: [ :card | card sameHolder: aCard ]
		ifFound: [ :card | cards remove: card ]
]
