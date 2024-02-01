Class {
	#name : #PlayerHand,
	#superclass : #Object,
	#instVars : [
		'owner',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PlayerHand class >> of: aPlayerColor [

	^ self new initializeOf: aPlayerColor
]

{ #category : #cards }
PlayerHand >> addCard: aCard [ 
	
	cards addLast: aCard.
]

{ #category : #information }
PlayerHand >> cards [

	^ cards
]

{ #category : #information }
PlayerHand >> has: aCard [

	cards
		detect: [ :card | card = aCard ]
		ifFound: [ ^ true ]
		ifNone: [ ^ false ]
]

{ #category : #initialization }
PlayerHand >> initializeOf: aPlayerColor [

	owner := aPlayerColor.
	cards := OrderedCollection new.
]

{ #category : #information }
PlayerHand >> owner [

	^ owner
]

{ #category : #accessing }
PlayerHand >> size [

	^ cards size
]

{ #category : #cards }
PlayerHand >> takeOut: aCard [

	cards
		detect: [ :card | card = aCard ]
		ifFound: [ :card | 
			cards remove: card.
			^ card ]
		ifNone: [ Error signal: 'There are no that type of cards activate in this player or is not a valid objective' ]
]
