Class {
	#name : #DuplaGalacticaGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'board',
		'goalLaps',
		'turnManager',
		'current',
		'cardManager',
		'boxes',
		'shaker'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
DuplaGalacticaGame class >> with: aColorCollection and: aBoard usingToThrow: aDiceShaker winningWhen: aValue using: aCardDealer [

	aColorCollection size <= 0 ifTrue: [ 
		Error signal: 'Cannot create a game with no players' ].
	aColorCollection do: [ :colorToTest | 
		(aColorCollection select: [ :color | color = colorToTest ]) size > 1 
			ifTrue: [ 
			Error signal: 'Cannot create a game with duplicate colors' ] ].
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
DuplaGalacticaGame >> addCardToCurrent [
	
	cardManager addCardTo: current color.
]

{ #category : #cards }
DuplaGalacticaGame >> apply: aCard [
	
	(cardManager canBeUse: aCard whenPlay: current color) ifFalse: [ 
		Error signal:
			'A permanent card can only be use when it is your turn' ].
	cardManager apply: aCard at: self.
]

{ #category : #information }
DuplaGalacticaGame >> boxes [

	^ boxes
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

	^ current color
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
	boxes := aBoard boxes.
	current := turnManager current.
	cardManager := CardManager using: aCardDealer with: aColorsCollection
]

{ #category : #cards }
DuplaGalacticaGame >> isPlaying: objective [

	objective isEmpty ifTrue: [ Error signal: 'The objective has not been specify' ].
	self playersColors
		detect: [ :color | color = objective ]
		ifFound: [ ^ true ]
		ifNone: [ Error signal: 'That is not a valid objective' ]
]

{ #category : #information }
DuplaGalacticaGame >> lightYears [

	^ board lightYears
]

{ #category : #player }
DuplaGalacticaGame >> moveAllToTheStart [

	players do: [ :player | 
		player move: player box * -1 + 1 andUpdateLap: boxes ]
]

{ #category : #player }
DuplaGalacticaGame >> moveCurrent: aValue [

	current move: aValue andUpdateLap: boxes
]

{ #category : #player }
DuplaGalacticaGame >> moveOthers: aValue [

	(players reject: [ :player | 
		 player color == current color ]) do: [ :player | 
		player move: aValue andUpdateLap: boxes]
]

{ #category : #player }
DuplaGalacticaGame >> movePlayer [

	| boxesToMove |
	self winnerExists ifTrue: [ ^ self ].
	boxesToMove := shaker throwDice.
	boxesToMove := boxesToMove + (cardManager calculateEffectOn: current color).
	self winnerExists ifTrue: [ ^ self ].
	current move: boxesToMove andUpdateLap: boxes.
	board effectAt: current box In: self.
	turnManager goNext.
	current := turnManager current
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
DuplaGalacticaGame >> playersColors [

	^ players collect: [ :player | player color ]
]

{ #category : #information }
DuplaGalacticaGame >> playersLaps [

	^ players collect: [ :player | player lap ]
]

{ #category : #information }
DuplaGalacticaGame >> playersPositions [

	^ players collect: [ :player | 
		  Position atTheBeginning move:
			  boxes * player lap + player box - 1 ]
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
DuplaGalacticaGame >> repeatEffectTo: aPlayerColor [

	| lastPosition |
	lastPosition := current box.
	current := players detect: [ :player | player color = aPlayerColor ].
	board effectAt: lastPosition In: self.
	current := turnManager current
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
