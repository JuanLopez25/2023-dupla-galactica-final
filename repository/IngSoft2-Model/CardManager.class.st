Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'cardsInPosetion',
		'lastCardPlay',
		'activeCards',
		'cardDealer',
		'objectiveOwner',
		'beingUse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardManager class >> using: aCardDealer with: aColorCollection [

	^ self new initializeUsing: aCardDealer with: aColorCollection
]

{ #category : #information }
CardManager >> active: aCard to: aPlayer [

	activeCards activeCard: aCard to: aPlayer
]

{ #category : #cards }
CardManager >> addCardTo: aColor [

	cardsInPosetion addCard: (cardDealer dealCard) to: aColor
]

{ #category : #cards }
CardManager >> apply: aCard at: aGame to: anObjective from: aPlayerColor [

	(cardsInPosetion hasBeenGiven: aCard to: aPlayerColor) ifFalse: [ 
		Error signal: 'The player does not have that card in posetion' ].
	aCard hasEffect ifTrue: [ lastCardPlay := aCard ].
	beingUse := aCard.
	aCard applyCardUsing: self at: aGame to: anObjective.
	cardsInPosetion takeOut: aCard to: aPlayerColor
]

{ #category : #cards }
CardManager >> apply: aCard at: aGame to: anObjective of: aHolder from: aPlayerColor [

	objectiveOwner:= aHolder.
	self apply: aCard at: aGame to: anObjective from: aPlayerColor. 
]

{ #category : #information }
CardManager >> beingUse [

	^ beingUse
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
	beingUse := EmptyObject new.
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
