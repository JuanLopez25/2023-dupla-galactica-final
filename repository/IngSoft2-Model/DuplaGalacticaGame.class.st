Class {
	#name : #DuplaGalacticaGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'board',
		'goalLaps',
		'turnManager',
		'cardManager',
		'shaker'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
DuplaGalacticaGame class >> with: aColorCollection and: aBoard usingToThrow: aDiceShaker winningWhen: aValue using: aCardDealer [

	| duplicateColors |
	aColorCollection size <= 0 ifTrue: [ 
		Error signal: 'Cannot create a game with no players' ].
	duplicateColors := aColorCollection
		                   detect: [ :color | 
		                   (aColorCollection occurrencesOf: color) > 1 ]
		                   ifNone: [ nil ].
	duplicateColors ifNotNil: [ 
		Error signal: 'Cannot create a game with duplicate colors' ].
	aValue <= 0 ifTrue: [ 
		Error signal: 'Cannot create a game with that goal laps' ].
	^ self new
		  initializeWith: aColorCollection
		  and: aBoard
		  usingToThrow: aDiceShaker
		  winningWhen: aValue
		  using: aCardDealer
]

{ #category : #cards }
DuplaGalacticaGame >> addCardTo: aPlayer [
	
	cardManager addCardTo: aPlayer color.
]

{ #category : #Information }
DuplaGalacticaGame >> amountToBoxes: anAmount [
	
	^ board amountToBoxes: anAmount.
]

{ #category : #cards }
DuplaGalacticaGame >> apply: aCard to: anObjective from: aPlayerColor [
	
	(cardManager canBeUse: aCard whenPlay: turnManager current color from: aPlayerColor) ifFalse: [ 
		Error signal:
			'A permanent card can only be use when it is your turn' ].
	cardManager apply: aCard at: self to: anObjective from: aPlayerColor.
]

{ #category : #cards }
DuplaGalacticaGame >> apply: aCard to: anObjectiveCard of: aHolder from: aPlayerColor [
	
	(cardManager canBeUse: aCard whenPlay: turnManager current color from: aPlayerColor) ifFalse: [ 
		Error signal:
			'A permanent card can only be use when it is your turn' ].
	cardManager apply: aCard at: self to: anObjectiveCard of: aHolder from: aPlayerColor.
]

{ #category : #information }
DuplaGalacticaGame >> boxes [

	^ board size
]

{ #category : #information }
DuplaGalacticaGame >> cardsInPosetionOf: aPlayer [

	^ cardManager cardsInPosetionOf: aPlayer
]

{ #category : #information }
DuplaGalacticaGame >> cardsToDeal [

	^ cardManager cardsToDeal
]

{ #category : #information }
DuplaGalacticaGame >> currentPlayer [

	^ turnManager current color
]

{ #category : #information }
DuplaGalacticaGame >> discardCardsDeskAmount [

	^ cardManager discardCardsDeskAmount
]

{ #category : #information }
DuplaGalacticaGame >> goalLaps [

	^ goalLaps
]

{ #category : #initialization }
DuplaGalacticaGame >> initializeWith: aColorsCollection and: aBoard usingToThrow: aDiceShaker winningWhen: aValue using: aCardDealer [

	players := aColorsCollection collect: [ :color | Player with: color ].
	board := aBoard.
	shaker := aDiceShaker.
	turnManager := QueueManager with: players.
	goalLaps := aValue.
	cardManager := CardManager using: aCardDealer with: aColorsCollection
]

{ #category : #information }
DuplaGalacticaGame >> lightYears [

	^ board lightYears
]

{ #category : #player }
DuplaGalacticaGame >> move: aPlayer amount: anAmount [

	aPlayer move: anAmount andUpdateLap: board size
]

{ #category : #player }
DuplaGalacticaGame >> moveAllToTheStart [

	players do: [ :player | 
		player move: player box * -1 + 1 andUpdateLap: board size ]
]

{ #category : #player }
DuplaGalacticaGame >> moveEveryone: effectValue except: aPlayer [

	(players reject: [ :player | 
		 player color == aPlayer color ]) do: [ :player | 
		player move: effectValue andUpdateLap: board size]
]

{ #category : #player }
DuplaGalacticaGame >> movePlayer [

	| boxesToMove |
	self winnerExists ifTrue: [ ^ self ].
	boxesToMove := shaker throwDice.
	boxesToMove := boxesToMove
	               +
	               (cardManager calculateEffectOn:
		                turnManager current color).
	turnManager current move: boxesToMove andUpdateLap: board size.
	board
		effectAt: turnManager current box
		in: self
		to: turnManager current.
	turnManager goNext
]

{ #category : #information }
DuplaGalacticaGame >> parsecs [

	^ board parsecs
]

{ #category : #information }
DuplaGalacticaGame >> playersBox [

	^ players collect: [ :player | player box ]
]

{ #category : #information }
DuplaGalacticaGame >> playersLaps [

	^ players collect: [ :player | player lap ]
]

{ #category : #finalization }
DuplaGalacticaGame >> ranking [

	| ranking |
	ranking := players collect: [ :player | player ].
	ranking sort: [ :player1 :player2 | 
		player1 aheadOf: player2 ].
	^ ranking collect: [ :player | player color ]
]

{ #category : #cards }
DuplaGalacticaGame >> repeatEffectTo: aColorPlayer [

	board effectAt: turnManager current box in: self to: (players
			 detect: [ :player | player color = aColorPlayer ]
			 ifNone: [ Error signal: 'That is not a valid objective' ])
]

{ #category : #finalization }
DuplaGalacticaGame >> winner [

	self winnerExists
		ifTrue: [ 
			^ (players detect: [ :player | self wins: player ])
				  color ]
		ifFalse: [ Error signal: 'There is no winner' ]
]

{ #category : #finalization }
DuplaGalacticaGame >> winnerExists [

	^ players anySatisfy: [ :player | self wins: player ]
]

{ #category : #finalization }
DuplaGalacticaGame >> wins: aPlayer [

	^ aPlayer lap >= self goalLaps
]
