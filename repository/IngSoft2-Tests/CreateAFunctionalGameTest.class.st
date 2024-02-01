Class {
	#name : #CreateAFunctionalGameTest,
	#superclass : #TestCase,
	#instVars : [
		'aColorCollection'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #Games }
CreateAFunctionalGameTest >> gameWithLoadedDie [

	| aLoadedGame aLoadedDie aBoard boxes aShaker aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 3.
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 9
			               with: 6
			               with: 7
			               with: 9).
	boxes:= (BoxCreator use: (OrderedCollection with: (BoxProbability using: EmptyObject new withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	
	aLoadedGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	^ aLoadedGame
]

{ #category : #Games }
CreateAFunctionalGameTest >> gameWithTwoLoadedDie [

	| aLoadedDie aSecondLoadedDie aShaker aGame boxes aBoard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 3.
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 4
			               with: 5
			               with: 1
			               with: 9).
	aSecondLoadedDie := LoadedDie with: (OrderedCollection
			                     with: 5
			                     with: 7
			                     with: 0
			                     with: 8).
	aShaker := DiceShaker withDie: aLoadedDie.
	aShaker addDie: aSecondLoadedDie.
	
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability using: EmptyObject new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 2
		         using: (CardDealer with: aDeck).
	^ aGame
]

{ #category : #running }
CreateAFunctionalGameTest >> setUp [

	super setUp.


	aColorCollection := OrderedCollection with: 'red' with: 'blue'
]

{ #category : #tests }
CreateAFunctionalGameTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
CreateAFunctionalGameTest >> testD001CreateGameAndAskForCurrentPlayer [

	| aLoadedGame |
	aLoadedGame := self gameWithLoadedDie.
	self
		assert: aLoadedGame currentPlayer 
		equals: 'red' 
]

{ #category : #tests }
CreateAFunctionalGameTest >> testD002CreateGameMoveThePlayersAndAskForWinner [

	| aLoadedGame |
	aLoadedGame := self gameWithLoadedDie.
	aLoadedGame movePlayer.
	aLoadedGame movePlayer.
	aLoadedGame movePlayer.
	self assert: aLoadedGame winner equals: 'red'
]

{ #category : #tests }
CreateAFunctionalGameTest >> testF001CreateGameWithLoadedDieMoveThePlayersAndAskForTheirBoxes [

	| aGame |
	aGame := self gameWithLoadedDie.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 1)
]

{ #category : #tests }
CreateAFunctionalGameTest >> testF002CreateGameWithLoadedDieAndThrowItThreeTimes [

	| aGame |
	aGame := self gameWithLoadedDie.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 7 with: 7)
]

{ #category : #tests }
CreateAFunctionalGameTest >> testG001CreateGameWithTwoDice [

	| aGame |
	aGame := self gameWithTwoLoadedDie.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 1)
]

{ #category : #tests }
CreateAFunctionalGameTest >> testG002CreateGameWithTwoDiceAndThrowThemTwoTimes [

	| aGame |
	aGame := self gameWithTwoLoadedDie.
	aGame movePlayer.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 3)
]

{ #category : #tests }
CreateAFunctionalGameTest >> testH001VerifyThatTheMovesDoNotHaveEffectAfterSomeoneWins [

	| aGame |
	aGame := self gameWithTwoLoadedDie.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 3)
]

{ #category : #tests }
CreateAFunctionalGameTest >> testL002AskForWinnerWhenNoOneWinsAndRaiseAnError [

	| aGame |
	aGame := self gameWithLoadedDie.
	aGame movePlayer.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There is no winner'
]

{ #category : #tests }
CreateAFunctionalGameTest >> testL003VerifyTheCorrectUseOfTheRankingAtADuplaGalacticaGameThenValid [

	| aGame |
	aGame := self gameWithTwoLoadedDie.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame ranking
		equals: (OrderedCollection with: 'blue' with: 'red')
]
