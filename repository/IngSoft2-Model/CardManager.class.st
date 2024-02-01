Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'cardsInPosetion',
		'lastCardPlay',
		'activeCards',
		'cardDealer',
		'objectiveOwner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardManager class >> using: aCardDealer with: aColorCollection [

	^ self new initializeUsing: aCardDealer with: aColorCollection
]

{ #category : #cards }
CardManager >> active: aCard to: aPlayer [

	activeCards activeCard: aCard to: aPlayer
]

{ #category : #cards }
CardManager >> addCardTo: aColor [

	cardsInPosetion addCard: (cardDealer dealCard) to: aColor
]

{ #category : #cards }
CardManager >> apply: aCard at: aGame to: anObjective of: aHolder from: aPlayerColor [

	objectiveOwner := aHolder.
	(cardsInPosetion hasBeenGiven: aCard to: aPlayerColor) ifFalse: [ 
		Error signal: 'The player does not have that card in posetion' ].
	aCard hasEffect ifTrue: [ lastCardPlay := aCard ].
	(self haveToActive: aCard)
		ifTrue: [ self active: aCard to: (aCard objectiveWhenTarget: anObjective using: self)  ]
		ifFalse: [ aCard applyCardUsing: self at: aGame to: anObjective. self discard: aCard ].
	objectiveOwner := EmptyObject new.
	cardsInPosetion takeOut: aCard to: aPlayerColor
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

{ #category : #cards }
CardManager >> haveToActive: aCard [

	^ lastCardPlay isEmpty not and: [aCard isPermanent or: [ 
		 lastCardPlay isPermanent and: aCard hasEffect not ]]
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
