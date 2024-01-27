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

{ #category : #'Changing cards' }
CardsInPosetionDeck >> addCard: aCard [

	(aCard isEmpty) ifFalse: [ cards addLast: aCard ].
]

{ #category : #'Changing cards' }
CardsInPosetionDeck >> cardsOf: aPlayerColor [

	^ (cards select: [ :card | card holder = aPlayerColor ]) size
]

{ #category : #'Changing cards' }
CardsInPosetionDeck >> hasBeenGiven: aCard [

	cards
		detect: [ :card | card = aCard ]
		ifFound: [ :card | ^ true ]
		ifNone: [ ^ false ]
]

{ #category : #Initialization }
CardsInPosetionDeck >> initializeDeck [
	cards:= OrderedCollection new.
]

{ #category : #Initialization }
CardsInPosetionDeck >> takeOut: aCard [

	cards remove: aCard.
]
