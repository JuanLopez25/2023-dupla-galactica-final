Class {
	#name : #BoxesTest,
	#superclass : #TestCase,
	#instVars : [
		'aColorCollection',
		'aDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
BoxesTest >> setUp [

	super setUp.

	aColorCollection := OrderedCollection with: 'red' with: 'blue'.
	aDeck := CardsDeck with: ((Creator use: (OrderedCollection with:
			           (ObjectProbability
				            using: AccelerationCard new
				            withChance: 100))) create: 7).
]

{ #category : #tests }
BoxesTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
BoxesTest >> testN001CheckNoEffectBoxDoesNotApplyAnyEffectThenValuePositions [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 6
			               with: 8
			               with: 5
			               with: 8).
	boxes := boxes := (Creator use: (OrderedCollection with:
			                    (ObjectProbability
				                     using: EmptyObject new
				                     withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.

	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 7 with: 9)
]

{ #category : #tests }
BoxesTest >> testN002CheckTheWormHoleBoxApplyANegativeEffectThenValuePositions [

	| aLoadedDie aGame boxes aBoard aShaker|
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 5
			               with: 8
			               with: 5
			               with: 8).
	boxes := (Creator use:
		          (OrderedCollection with:  (ObjectProbability using: WormHoleBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 5)
]

{ #category : #tests }
BoxesTest >> testN003CheckSpeedUpBoxApplyAPositiveEffectOnThePositionThenValuePositions [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 8
			               with: 5
			               with: 8).
	boxes := boxes := (Creator use:
		                   (OrderedCollection with:
			                     (ObjectProbability using: SpeedUpBox new withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 6 with: 3)
]

{ #category : #tests }
BoxesTest >> testN004CheckMoonWalkBoxApplyTheCorrectEffectOnTheOtherPlayersThenValuePositions [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 8
			               with: 3
			               with: 5
			               with: 8).
	boxes := (Creator
		          use: (OrderedCollection with:  (ObjectProbability using: (MoonWalkBox with: -2) withChance: 100))) create:
		         10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 7 with: 4)
]

{ #category : #tests }
BoxesTest >> testN005CheckAtomicBombBoxMoveAllPlayersToTheBeginning [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 8
			               with: 7
			               with: 5
			               with: 8).
	boxes := (Creator use:
		          (OrderedCollection with:  (ObjectProbability using: AtomicBombBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
BoxesTest >> testN006CheckHyperJumpBoxMoveTheCorrectAmountOfParsecsWhenTheyAreEntireValuesThenValuePositions [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 4
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with: (ObjectProbability
				            using: (HyperJumpBox with:
						             (OrderedCollection
							              with: (Parsec worth: 40)
							              with: (Parsec worth: 30)))
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 8 with: 9)
]

{ #category : #tests }
BoxesTest >> testN007CheckWormHoleBoxDoesNotAllowPlayerToBeAtANegativePosition [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 8
			               with: 5
			               with: 8).
	boxes := (Creator use:
		          (OrderedCollection with: (ObjectProbability using: WormHoleBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 5)
]

{ #category : #tests }
BoxesTest >> testN008CheckMoonWalkBoxDoesNotAllowPlayersToBeAtANegativePosition [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 4
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with:
			           (ObjectProbability
				            using: (MoonWalkBox with: -4)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 5)
]

{ #category : #tests }
BoxesTest >> testN009CheckHyperJumpBoxDoesNotAllowPlayersToBeAtANegativePosition [

	| aLoadedDie aGame boxes aBoard aShaker  |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 3
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with: (ObjectProbability
				            using: (HyperJumpBox with:
						             (OrderedCollection
							              with: (Parsec worth: -40)
							              with: (Parsec worth: -10)))
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 1)
]

{ #category : #tests }
BoxesTest >> testN010CheckTheEffectApplysAlsoWhenTheSpaceshipReachTheGoal [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 11
			               with: 3
			               with: 5
			               with: 8).
	boxes := (Creator use:
		          (OrderedCollection with: (ObjectProbability using: WormHoleBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	self
		should: [ aGame winner ]
		raise: Error
		withMessage: 'There is no winner'
]

{ #category : #tests }
BoxesTest >> testN011CheckHyperJumpBoxMoveTheCorrectAmountOfParsecsWhenTheyAreNotEntireValuesThenValuePositions [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 3
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with: (ObjectProbability
				            using: (HyperJumpBox with: (OrderedCollection
							              with: (Parsec worth: 45.5)
							              with: (Parsec worth: 34.9)))
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 8 with: 7)
]

{ #category : #tests }
BoxesTest >> testN012CheckTheWormHoleEffectWhenHasPassedTheFirstLap [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 13
			               with: 8
			               with: 1
			               with: 8).
	boxes := (Creator use:
		          (OrderedCollection with: (ObjectProbability using: WormHoleBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 5)
]

{ #category : #tests }
BoxesTest >> testR001CheckRandomCardBoxGeneratesARandomCard [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 5
			               with: 5
			               with: 8).
	boxes := (Creator use:
		          (OrderedCollection with: (ObjectProbability using: (RandomCardBox new)  withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	self
		assert: (aGame cardsInPosetionOf: 'red')
		equals: 3.
	self
		assert: (aGame cardsInPosetionOf: 'blue')
		equals: 2
]

{ #category : #tests }
BoxesTest >> testR002CheckRandomCardBoxGeneratesARandomCardMoreThanOneTimeIfNecessary [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 3
			               with: 3
			               with: 8).
	boxes := (Creator use:
		          (OrderedCollection with: (ObjectProbability using: (RandomCardBox new) withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: (aGame cardsInPosetionOf: 'red')
		equals: 4.
	self
		assert: (aGame cardsInPosetionOf: 'blue')
		equals: 3
]

{ #category : #tests }
BoxesTest >> testR003CheckRandomCardBoxGeneratesAsRandomCardsAsSpecify [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 3
			               with: 3
			               with: 8).
	boxes := (Creator use:
		          (OrderedCollection with: (ObjectProbability using: (RandomCardBox new) withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: (aGame cardsInPosetionOf: 'red')
		equals: 4.
	self
		assert: (aGame cardsInPosetionOf: 'blue')
		equals: 3.
]

{ #category : #tests }
BoxesTest >> testT001CheckHyperJumpBoxMoveTheCorrectAmountOfBoxesWhenTheValuesAreGivenInLightYears [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 3
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with: (ObjectProbability
				            using: (HyperJumpBox with: (OrderedCollection
							              with: (LigthYear worth: 120)
							              with: (LigthYear worth: 90)))
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 8 with: 7)
]

{ #category : #tests }
BoxesTest >> testT002CheckHyperJumpBoxMoveTheCorrectAmountOfBoxesWhenTheValuesAreGivenInLightYearsAndParsecs [

	| aLoadedDie aGame boxes aBoard aShaker|
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 3
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with: (ObjectProbability
				            using: (HyperJumpBox with: (OrderedCollection
							              with: (LigthYear worth: 120)
							              with: (Parsec worth: 30)))
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 8 with: 7)
]

{ #category : #tests }
BoxesTest >> testT003CheckHyperJumpBoxCannotBeCreatedIfDoesNotHaveValuesToUse [

	self
		should: [ 
			(Creator use: (OrderedCollection with:
					  (ObjectProbability using: (HyperJumpBox with: OrderedCollection new) withChance: 100))) 
				create: 10 ]
		raise: Error
		withMessage: 'There are no values to use in the hyper jump box'
]

{ #category : #tests }
BoxesTest >> testT004CheckHyperJumpBoxMoveTheCorrectAmountOfBoxesWhenTheValuesAreGivenInLightYearsAndParsecsAndAlsoTheyAreNegative [

	
	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 3
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with: (ObjectProbability
				            using: (HyperJumpBox with: (OrderedCollection
							              with: (LigthYear worth: -60)
							              with: (Parsec worth: -30)))
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
BoxesTest >> testT005CheckPlayerMoveBackwardAsManyLapsAsRequest [

	| aLoadedDie aGame boxes aBoard aShaker|
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 10
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with: (ObjectProbability
				            using:
				            (HyperJumpBox with:
					             (OrderedCollection with: (Parsec worth: -120)))
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 2
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
BoxesTest >> testU001VerifyTheCorrectUseOfSprintBox [

	| aLoadedDie aGame boxes aBoard aShaker |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 3
			               with: 1
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with:
			           (ObjectProbability using: SprintBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 2
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 6 with: 4)
]

{ #category : #tests }
BoxesTest >> testU002VerifyTheCorrectUseOfSprintBoxWhenAPlayerHave1Card [

	| aLoadedDie aGame boxes aBoard aShaker aCard |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with:
			           (ObjectProbability using: SprintBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 2
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 5)
]

{ #category : #tests }
BoxesTest >> testU003VerifyTheCorrectUseOfSprintBoxWhenThePlayerDoesNotHaveCards [

	| aLoadedDie aGame boxes aBoard aShaker aCard |
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 5
			               with: 8).
	boxes := (Creator use: (OrderedCollection with:
			           (ObjectProbability using: SprintBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 2
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 6)
]
