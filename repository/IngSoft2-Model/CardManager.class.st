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

{ #category : #information }
CardManager >> activeCard: aCard [

	activeCards activeCard: aCard
]

{ #category : #cards }
CardManager >> addAmountOfCards: anAmount to: aColor [

	anAmount timesRepeat: [ 
		cardsInPosetion addCard: (cardDealer createCardFor: aColor) ]
]

{ #category : #cards }
CardManager >> apply: aCard at: aGame [

	(self hasBeenGiven: aCard) ifFalse: [ 
		Error signal: 'The player does not have that card in posetion' ].

	aCard hasEffect ifTrue: [ lastCardPlay := aCard ].
	aCard applyCardUsing: self at: aGame.
	cardsInPosetion takeOut: aCard
]

{ #category : #cards }
CardManager >> calculateEffectOn: aColorPlayer [

	^ activeCards calculateEffectOn: aColorPlayer
]

{ #category : #cards }
CardManager >> canBeUse: aCard whenPlay: aPlayer [

	aCard holder isEmpty ifTrue: [ 
		Error signal: 'The card does not have a holder' ].
	^ (aCard isPermanent and: aCard holder = aPlayer) or:
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

	activeCards desactivate: anObjectiveCard.
	cardDealer discard: anObjectiveCard
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
CardManager >> hasBeenGiven: aCard [

	^ cardsInPosetion hasBeenGiven: aCard
]

{ #category : #initialization }
CardManager >> initializeUsing: aCardDealer with: aColorCollection [

	lastCardPlay := EmptyObject new.
	cardDealer := aCardDealer.
	activeCards := ActiveCardsDeck createDeck.
	cardsInPosetion := CardsInPosetionDeck createDeck.
	aColorCollection do: [ :color | 
		cardsInPosetion addCard: (cardDealer createCardFor: color).
		cardsInPosetion addCard: (cardDealer createCardFor: color) ]
]

{ #category : #information }
CardManager >> lastCardPlay [

	^ lastCardPlay
]
