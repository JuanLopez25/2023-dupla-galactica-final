Class {
	#name : #CreateDuplaGalacticaGameTest,
	#superclass : #TestCase,
	#instVars : [
		'aColorCollection',
		'aLoadedDie',
		'aShaker'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #Games }
CreateDuplaGalacticaGameTest >> createGameWithEffects [

	| aGame aBoard aBoxCreator boxes boxesProbabilities aDeck cards |
	cards := (Creator use: (OrderedCollection with:
			           (ObjectProbability
				            using: OverloadCard new
				            withChance: 100))) create: 3.
	aDeck := CardsDeck with: cards.
	boxesProbabilities := OrderedCollection
		                      with:
		                      (ObjectProbability
			                       using: EmptyObject new
			                       withChance: 30)
		                      with:
		                      (ObjectProbability
			                       using: WormHoleBox new
			                       withChance: 20)
		                      with:
		                      (ObjectProbability
			                       using: SpeedUpBox new
			                       withChance: 20)
		                      with:
		                      (ObjectProbability
			                       using: (MoonWalkBox with: -2)
			                       withChance: 10)
		                      with:
		                      (ObjectProbability
			                       using: AtomicBombBox new
			                       withChance: 2)
		                      with: (ObjectProbability
				                       using: (HyperJumpBox with:
						                        (OrderedCollection
							                         with: (Parsec worth: 40)
							                         with: (Parsec worth: 30)))
				                       withChance: 8).
	boxesProbabilities addLast:
		(ObjectProbability using: (RandomCardBox new) withChance: 10).
	aBoxCreator := Creator use: boxesProbabilities.
	boxes := aBoxCreator create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 200).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	^ aGame
]

{ #category : #running }
CreateDuplaGalacticaGameTest >> setUp [

	super setUp.
	aColorCollection := OrderedCollection with: 'red' with: 'blue'.
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 9
			               with: 10
			               with: 7
			               with: 9).

	aShaker := DiceShaker withDie: aLoadedDie
]

{ #category : #tests }
CreateDuplaGalacticaGameTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
CreateDuplaGalacticaGameTest >> testP001VerifyTheCorrectCreationOfTheBoardWithEffectsAndAskForItsBoardLength [

	| aGame |
	aGame := self createGameWithEffects.

	self assert: aGame boxes identicalTo: 10
]

{ #category : #tests }
CreateDuplaGalacticaGameTest >> testP003VerifyTheCorrectUseOfTurns [

	| aGame |
	aGame := self createGameWithEffects.
	aGame movePlayer.
	self assert: aGame currentPlayer equals: 'blue'
]

{ #category : #tests }
CreateDuplaGalacticaGameTest >> testP004VerifyTheCorrectCreationOfABoardWithOneGoalLap [

	| aGame |
	aGame := self createGameWithEffects.
	self assert: aGame goalLaps identicalTo: 1
]

{ #category : #tests }
CreateDuplaGalacticaGameTest >> testP016AskingForAWinnerBeforeAnyoneMoves [

	| aGame |
	aGame := self createGameWithEffects.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There is no winner'
]

{ #category : #tests }
CreateDuplaGalacticaGameTest >> testP017TryToCreatAGameWhenNoColorHasBeenPassThenRaiseAnError [

	self
		should: [ 
			DuplaGalacticaGameProxy
				with: OrderedCollection new
				and: (Board
						 with: (OrderedCollection
								  with: EmptyObject new
								  with: EmptyObject new
								  with: EmptyObject new
								  with: EmptyObject new)
						 measure: (Parsec worth: 200))
				usingToThrow: (OrderedCollection with: aLoadedDie)
				winningWhen: 1
				using: CardDealer new ]
		raise: Error
		withMessage: 'Cannot create a game with no players'
]

{ #category : #tests }
CreateDuplaGalacticaGameTest >> testP018TryToCreateAGameWhenTheGoalLapsAreInvalidThenRaiseAnError [

	self
		should: [ 
			DuplaGalacticaGame
				with: aColorCollection
				and: (Board
						 with: (OrderedCollection
								  with: EmptyObject new
								  with: EmptyObject new
								  with: EmptyObject new
								  with: EmptyObject new)
						 measure: (Parsec worth: 200))
				usingToThrow: (DiceShaker withDie: aLoadedDie)
				winningWhen: -1
				using: CardDealer new ]
		raise: Error
		withMessage: 'Cannot create a game with that goal laps'
]

{ #category : #tests }
CreateDuplaGalacticaGameTest >> testP019TryToCreateAGameWhenTheParsecsAmountAreInvalidThenRaiseAnError [

	self
		should: [ 
			DuplaGalacticaGameProxy
				with: aColorCollection
				and: (Board with: (OrderedCollection new) measure: (Parsec worth: 0))
				usingToThrow: (DiceShaker withDie: aLoadedDie)
				winningWhen: 1
				using: CardDealer new ]
		raise: Error
		withMessage: 'Cannot create a game a negative parsec amount'
]

{ #category : #tests }
CreateDuplaGalacticaGameTest >> testP020TryToCreateAGameWithDuplicateColorsThenRaiseAnError [

	| aDuplicateColorCollection boxes aBoard |
	aDuplicateColorCollection := OrderedCollection
		                             with: 'red'
		                             with: 'red'.
	boxes := (Creator use: (OrderedCollection with: (ObjectProbability using: EmptyObject new withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	self
		should: [ 
			DuplaGalacticaGameProxy
				with: aDuplicateColorCollection
				and: aBoard
				usingToThrow: (DiceShaker withDie: aLoadedDie)
				winningWhen: 1
				using: CardDealer new ]
		raise: Error
		withMessage: 'Cannot create a game with duplicate colors'
]
