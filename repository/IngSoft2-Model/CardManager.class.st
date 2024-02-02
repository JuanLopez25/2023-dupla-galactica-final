Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'cardsInPosetion',
		'lastCardPlay',
		'activeCards',
		'cardDealer'
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
CardManager >> apply: aCard at: aGame to: anObjective from: aPlayerColor [

	self apply: aCard at: aGame to: anObjective of: EmptyObject new from: aPlayerColor
]

{ #category : #cards }
CardManager >> apply: aCard at: aGame to: anObjective of: aHolder from: aPlayerColor [

	(cardsInPosetion hasBeenGiven: aCard to: aPlayerColor) ifFalse: [ 
		^ self ].
	aCard hasEffect ifTrue: [ lastCardPlay := aCard ].
	(self hasToActive: aCard)
		ifTrue: [ 
			self
				active: aCard
				to: (aCard objectiveWhenTarget: anObjective using: self) ]
		ifFalse: [ 
			aCard applyCardUsing: self at: aGame to: anObjective of: aHolder.
			self discard: aCard ].
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
CardManager >> desactivate: anObjectiveCard of: aHolder [

	cardDealer discard: (activeCards desactivate: anObjectiveCard to: aHolder)
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
CardManager >> hasToActive: aCard [

	^ lastCardPlay isEmpty not and: [aCard isPermanent or: [ 
		 lastCardPlay isPermanent and: aCard hasEffect not ]]
]

{ #category : #initialization }
CardManager >> initializeUsing: aCardDealer with: aColorCollection [

	lastCardPlay := EmptyObject new.
	cardDealer := aCardDealer.
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
