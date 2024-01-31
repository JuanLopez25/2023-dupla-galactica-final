Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'cardsInPosetion',
		'lastCardPlay',
		'activeCards',
		'cardDealer',
		'objectiveOwner',
		'beingUsed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardManager class >> using: aCardDealer with: aColorCollection [

	^ self new initializeUsing: aCardDealer with: aColorCollection
]

{ #category : #information }
CardManager >> activeCardTo: aPlayer [

	activeCards activeCard: beingUsed to: aPlayer
]

{ #category : #cards }
CardManager >> addCardTo: aColor [

	cardsInPosetion addCard: (cardDealer dealCard) to: aColor
]

{ #category : #cards }
CardManager >> apply: aCard at: aGame to: anObjective from: aPlayerColor [

	| objective |
	(cardsInPosetion hasBeenGiven: aCard to: aPlayerColor) ifFalse: [ 
		Error signal: 'The player does not have that card in posetion' ].
	aCard hasEffect ifTrue: [ lastCardPlay := aCard ].
	objective := aCard applyCardUsing: self at: aGame to: anObjective.
	beingUsed := aCard.
	objective isEmpty
		ifTrue: [ self discard: aCard ]
		ifFalse: [ self activeCardTo: objective ].
	cardsInPosetion takeOut: aCard to: aPlayerColor
]

{ #category : #cards }
CardManager >> apply: aCard at: aGame to: anObjective of: aHolder from: aPlayerColor [

	objectiveOwner:= aHolder.
	self apply: aCard at: aGame to: anObjective from: aPlayerColor. 
]

{ #category : #cards }
CardManager >> calculateEffectOn: aColorPlayer [

	^ activeCards calculateEffectOn: aColorPlayer
]

{ #category : #cards }
CardManager >> canBeUse: aCard whenPlay: currentPlayerColor from: aPlayerColor [

	^ (aCard isPermanent and: aPlayerColor = currentPlayerColor) or:
		  aCard isPermanent not
]

{ #category : #information }
CardManager >> cardsInPosetionOf: player [

	^ cardsInPosetion cardsOf: player
]

{ #category : #information }
CardManager >> cardsToDeal [

	^ cardDealer cardsToDeal
]

{ #category : #cards }
CardManager >> desactivate: anObjectiveCard [

	cardDealer discard: (activeCards desactivate: anObjectiveCard to: objectiveOwner)
]

{ #category : #cards }
CardManager >> discard: aCard [

	cardDealer discard: aCard
]

{ #category : #information }
CardManager >> discardCardsDeskAmount [

	^ cardDealer discardCardsDeskAmount
]

{ #category : #initialization }
CardManager >> initializeUsing: aCardDealer with: aColorCollection [

	lastCardPlay := EmptyObject new.
	cardDealer := aCardDealer.
	objectiveOwner := EmptyObject new.
	activeCards := ActiveCardsDeck createDeckFor: aColorCollection.
	cardsInPosetion := CardsInPosetionDeck createDeckFor: aColorCollection.
	aColorCollection do: [ :color | 
		2 timesRepeat: [ 
			cardsInPosetion addCard: (cardDealer dealCard) to: color ] ]
]

{ #category : #information }
CardManager >> lastCardPlay [

	^ lastCardPlay
]
