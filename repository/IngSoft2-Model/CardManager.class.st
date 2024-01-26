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

{ #category : #Information }
CardManager >> activeCard: aCard [

	activeCards activeCard: aCard
]

{ #category : #Managing }
CardManager >> addAmountOfCards: anAmount to: aColor [

	anAmount timesRepeat: [ 
		cardsInPosetion addCard: (cardDealer createCardFor: aColor) ]
]

{ #category : #Managing }
CardManager >> apply: aCard at: aGame [

	(self hasBeenGiven: aCard) ifFalse: [ 
		Error signal: 'The player does not have that card in posetion' ].

	aCard haveEffect ifTrue: [ lastCardPlay := aCard ].
	aCard applyCardUsing: self at: aGame.
	cardDealer discard: aCard.
	cardsInPosetion takeOut: aCard
]

{ #category : #Managing }
CardManager >> calculateEffectOn: aColorPlayer [

	^ activeCards calculateEffectOn: aColorPlayer
]

{ #category : #Managing }
CardManager >> canBeUse: aCard whenPlay: aPlayer [

	^ (aCard isPermanent and: (aCard isHolder: aPlayer)) or:
		  aCard isPermanent not
]

{ #category : #Information }
CardManager >> cardsInPosetionOf: player [

	^ cardsInPosetion cardsOf: player
]

{ #category : #Information }
CardManager >> cardsToDeal [
	^ cardDealer cardsToDeal.
]

{ #category : #Managing }
CardManager >> desactivate: anObjectiveCard [


	activeCards desactivate: anObjectiveCard.
]

{ #category : #Information }
CardManager >> discardCardsDeskAmount [
	^ cardDealer discardCardsDeskAmount.
]

{ #category : #Managing }
CardManager >> hasBeenGiven: aCard [

	^ cardsInPosetion hasBeenGiven: aCard
]

{ #category : #Initialization }
CardManager >> initializeUsing: aCardDealer with: aColorCollection [

	lastCardPlay := EmptyCard new.
	cardDealer := aCardDealer.
	activeCards := ActiveCards createDeck.
	cardsInPosetion := CardsInPosetion createDeck.
	aColorCollection do: [ :color | 
		cardsInPosetion addCard: (cardDealer createCardFor: color).
		cardsInPosetion addCard: (cardDealer createCardFor: color) ]
]

{ #category : #information }
CardManager >> lastCardPlay [
	^ lastCardPlay
]
