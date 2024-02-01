Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#instVars : [
		'aColorCollection',
		'aShaker'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #Game }
CardsTest >> createBoard [

	| boxes aBoard |
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability using: EmptyObject new withChance: 100))) create: 10.
	^ aBoard := Board with: boxes measure: (Parsec worth: 100).
]

{ #category : #Creation }
CardsTest >> createBoardWithRandomCardBoxes [

	| boxes |
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability
				            using: (RandomCardBox new)
				            withChance: 100))) create: 10.
	^ Board with: boxes measure: (Parsec worth: 100)
]

{ #category : #running }
CardsTest >> setUp [

	| aLoadedDie |
	super setUp.
	aColorCollection := OrderedCollection with: 'red' with: 'blue'.
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 2
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie
]

{ #category : #tests }
CardsTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
CardsTest >> testQ001VerifyTheCorrectUseOfOverloadCard [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testQ003VerifyTheCorrectUseOfOverloadCardWhenThePlayerHasToGoBackwardsDueToANegativeEffect [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 1)
]

{ #category : #tests }
CardsTest >> testQ004VerifyTheCorrectUseOfOverloadCardWhenThePlayerHasToGoBackwardsInTheFirstLapDueToANegativeEffect [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 3).
	self
		assert: aGame playersLaps
		equals: (OrderedCollection with: 0 with: 0)
]

{ #category : #tests }
CardsTest >> testQ005VerifyTheCorrectUseOfASpeedCard [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : #tests }
CardsTest >> testQ006VerifyTheCorrectUseOfASpeedCardWhenThrowingMoreThanOneTime [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 6 with: 4)
]

{ #category : #tests }
CardsTest >> testQ007VerifyTheCorrectUseOfASpeedCardWhenHasToRaiseALap [

	| aGame aCard aDeck aDie aLoadedShaker |
	aDie := LoadedDie with: (OrderedCollection
			         with: 9
			         with: 2
			         with: 3
			         with: 5).
	aLoadedShaker := DiceShaker withDie: aDie.
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aLoadedShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersLaps
		equals: (OrderedCollection with: 1 with: 0)
]

{ #category : #tests }
CardsTest >> testQ008VerifyTheCorrectUseOfPermanentCardsWhenAPlayerHasMoreThanOneActive [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 3)
]

{ #category : #tests }
CardsTest >> testQ009VerifyTheCorrectUseOfAccelerationCard [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: AccelerationCard new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testQ010VerifyTheCorrectUseOfAccelerationCardWhenHasToRaiseALap [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: AccelerationCard new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 8)
]

{ #category : #tests }
CardsTest >> testQ011VerifyTheCorrectUseOfCancellationCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: OverloadCard new amount: 2.
	aDeck addCard: CancellationCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: OverloadCard new
		of: 'blue'
		from: 'blue'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ012VerifyTheCorrectUseOfCancellationCardWhenThePlayerHasMoreThanOneCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: SpeedCard new amount: 2.
	aDeck addCard: CancellationCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 1)
]

{ #category : #tests }
CardsTest >> testQ013VerifyTheCorrectUseOfTwoCancellationCards [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: SpeedCard new amount: 2.
	aDeck addCard: CancellationCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ014TryToCancellAPermanentCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: CancellationCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := CancellationCard new.
	self
		should: [ 
			aGame
				apply: aCard
				to: OverloadCard new
				of: 'red'
				from: 'red' ]
		raise: Error
		withMessage: 'There are no that type of cards activate in this player or is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ015TryToCancellAPermanentCardWithATypeOfCardThatIsNotActivate [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: OverloadCard new amount: 2.
	aDeck addCard: CancellationCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard new).
	aGame
		apply: aCard
		to: 'blue'
		from: 'red'.
	aCard := CancellationCard new.
	self
		should: [ 
			aGame
				apply: aCard
				to: OverloadCard new
				of: 'red'
				from: 'blue' ]
		raise: Error
		withMessage:
		'There are no that type of cards activate in this player or is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ017TryToUseAnOverLoadCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	self
		should: [ aGame apply: aCard to: 'red' from: 'blue' ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
]

{ #category : #tests }
CardsTest >> testQ018TryToUseASpeedCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	self
		should: [ aGame apply: aCard to: 'red' from: 'red' ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ019TryToUseAnAccelerationCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.

	self
		should: [ aGame apply: aCard to: 'red' from: 'red' ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ020UseTwoOverLoadCardsFromTheSamePlayerToTheSamePlayer [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testQ021UseAnOverLoadCardAndThenTryToUseItAgainButItHasGoneAway [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aCard := OverloadCard new.
	self
		should: [ aGame apply: aCard to: 'blue' from: 'red' ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ022UseTwoSpeedCardsFromTheSamePlayerToTheSamePlayer [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 3)
]

{ #category : #tests }
CardsTest >> testQ023UseASpeedCardAndThenTryToUseItAgainButItHasGoneAway [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := SpeedCard new.
	self
		should: [ aGame apply: aCard to: 'red' from: 'red' ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ024UseTwoAccelerationCardsFromTheSamePlayer [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: AccelerationCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 5)
]

{ #category : #tests }
CardsTest >> testQ025UseAnAccelerationCardAnThenTryToUseItAgainButItHasGoneAway [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: AccelerationCard new amount: 6.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aCard := AccelerationCard new.
	self
		should: [ aGame apply: aCard to: EveryPlayer new from: 'red' ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ026TryToUseACancellationCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).

	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aCard := CancellationCard new.
	self
		should: [ aGame apply: aCard to: 'blue' from: 'red' ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ026TryToUseACancellationCardWithANonValidObjective [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: OverloadCard new amount: 2.
	aDeck addCard: CancellationCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aCard := CancellationCard new.
	self
		should: [ aGame apply: aCard to: 'red' from: 'blue' ]
		raise: Error
		withMessage:
		'There are no that type of cards activate in this player or is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ027UseTwoCancellationCardsFromTheSamePlayer [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: OverloadCard new amount: 2.
	aDeck addCard: CancellationCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 2
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: OverloadCard new
		of: 'blue'
		from: 'blue'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: OverloadCard new
		of: 'blue'
		from: 'blue'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ029VerifyTheCorrectUseOfRedoCardWhenLastCardPlayIsAnOverloadCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: OverloadCard new amount: 2.
	aDeck addCard: RedoCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard new).
	aGame apply: aCard to: 'blue' from: 'red'.
	aGame movePlayer.
	aCard := (RedoCard create).
	aGame apply: aCard to: 'red' from: 'blue'.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testQ030VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsACancellationCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: SpeedCard new amount: 2.
	aDeck addCard: CancellationCard new amount: 1.
	aDeck addCard: RedoCard new amount: 1.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	aCard := RedoCard create.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ031VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsASpeedCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: SpeedCard new amount: 2.
	aDeck addCard: RedoCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aGame movePlayer.
	aCard := RedoCard create.
	aGame apply: aCard to: 'blue' from: 'blue'.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testQ032VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsAnAccelerationCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: AccelerationCard new amount: 2.
	aDeck addCard: RedoCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aGame movePlayer.
	aCard := RedoCard create.
	aGame apply: aCard to: EveryPlayer new from: 'blue'.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 5)
]

{ #category : #tests }
CardsTest >> testQ033VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsARedoCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: AccelerationCard new amount: 2.
	aDeck addCard: RedoCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aGame movePlayer.
	aCard := RedoCard create.
	aGame apply: aCard to: EveryPlayer new from: 'blue'.
	aCard := RedoCard create.
	aGame apply: aCard to: EveryPlayer new from: 'blue'.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 6)
]

{ #category : #tests }
CardsTest >> testQ034VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsASpeedUpOne [

	| aGame aCard aDeck boxes aBoard |
	aDeck := CardsDeck create.
	aDeck addCard: RepeatCard new amount: 4.
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability using: SpeedUpBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := RepeatCard new.
	aGame apply: aCard to: 'red' from: 'red'.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 7)
]

{ #category : #tests }
CardsTest >> testQ035VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsAWormHoleOne [

	| aGame boxes aBoard aCard aDeck aDie aLoadedShaker |
	aDeck := CardsDeck create.
	aDeck addCard: RepeatCard new amount: 4.
	aDie := LoadedDie with: (OrderedCollection
			         with: 4
			         with: 9
			         with: 3
			         with: 4).
	aLoadedShaker := DiceShaker withDie: aDie.
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability using: WormHoleBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aLoadedShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := RepeatCard new.
	aGame apply: aCard to: 'blue' from: 'red'.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 2)
]

{ #category : #tests }
CardsTest >> testQ036VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsAMoonWalkOne [

	| aGame aLoadedDie boxes aBoard aLoadedShaker aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: RepeatCard new amount: 4.
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 4
			               with: 5
			               with: 3
			               with: 4).
	aLoadedShaker := DiceShaker withDie: aLoadedDie.
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (MoonWalkBox with: -2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aLoadedShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).


	aGame movePlayer.
	aGame movePlayer.
	aCard := RepeatCard new.
	aGame apply: aCard to: 'red' from: 'red'.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testQ037VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsAnAtomicBombOne [

	| aGame boxes aBoard aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: RepeatCard new amount: 4.
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability using: AtomicBombBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := RepeatCard new.
	aGame apply: aCard to: 'red' from: 'red'.


	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
CardsTest >> testQ038VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsHyperJumpOne [

	| aGame boxes aBoard aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: RepeatCard new amount: 4.
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability
				            using:
				            (HyperJumpBox with:
					             (OrderedCollection with: (Parsec worth: 40)))
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := RepeatCard new.
	aGame apply: aCard to: 'red' from: 'red'.


	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 7)
]

{ #category : #tests }
CardsTest >> testQ039VerifyThatAccelerationCardCanOnlyBePlayedAtPlayersTurns [

	| aGame aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: AccelerationCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	self
		should: [ 
		aGame apply: AccelerationCard new to: EveryPlayer new from: 'red' ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
]

{ #category : #tests }
CardsTest >> testQ041VerifyThatSpeedCardCanOnlyBePlayedAtPlayersTurns [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aCard := SpeedCard new.
	self
		should: [ aGame apply: aCard to: 'red' from: 'red' ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
]

{ #category : #tests }
CardsTest >> testQ042VerifyThatCancellationCardCanBePlayWheneverThePlayerWants [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: CancellationCard new amount: 2.
	aDeck addCard: AccelerationCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'blue'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: AccelerationCard new
		of: EveryPlayer new
		from: 'red'.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ043VerifyThatRedoCardCanBePlayWheneverThePlayerWants [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: AccelerationCard new amount: 2.
	aDeck addCard: RedoCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aCard := RedoCard create.
	aGame apply: aCard to: EveryPlayer new from: 'blue'.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 1)
]

{ #category : #tests }
CardsTest >> testQ044VerifyThatRepeatCardCanBePlayWheneverThePlayerWants [

	| aGame boxes aBoard aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: RepeatCard new amount: 4.
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability using: SpeedUpBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aCard := RepeatCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 7)
]

{ #category : #tests }
CardsTest >> testQ045VerifyThatRedoCardCanRepeatTheEffectOfTheRepeatCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: RepeatCard new amount: 2.
	aDeck addCard: RedoCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoardWithRandomCardBoxes
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).

	aGame movePlayer.
	aCard := RepeatCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := RedoCard create.
	aGame apply: aCard to: 'blue' from: 'blue'.

	self assert: (aGame cardsInPosetionOf: 'red') equals: 1.
	self assert: (aGame cardsInPosetionOf: 'blue') equals: 2
]

{ #category : #tests }
CardsTest >> testQ048VerifyThatWhenUsingAnOverloadCardTheObjectiveMustBeAValidPlayer [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	self
		should: [ aGame apply: aCard to: AccelerationCard new from: 'red' ]
		raise: Error
		withMessage: 'There are no that type of cards activate in this player or is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ050VerifyThatWhenUsingASpeedCardTheObjectiveMustBeAValidPlayer [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	self
		should: [ aGame apply: aCard to: AccelerationCard new from: 'red' ]
		raise: Error
		withMessage: 'There are no that type of cards activate in this player or is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ051VerifyThatWhenUsingARepeatCardTheObjectiveMustBeAValidPlayer [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: RepeatCard new amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := RepeatCard new.
	self
		should: [ aGame apply: aCard to: 'pepe' from: 'red' ]
		raise: Error
		withMessage: 'That is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ052VerifyThatWhenUsingARedoCardACardHasToBeenPlayedBefore [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: RedoCard new amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := RedoCard create.
	self
		should: [ aGame apply: aCard to: 'pepe' from: 'red' ]
		raise: Error
		withMessage:
		'Redo card cannot be played because there are no cards that have been played before'
]

{ #category : #tests }
CardsTest >> testV001VerifyThatNoCardsHasBeenDiscardAtTheBeggining [

	| aGame aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: RedoCard new amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	self
		assert: (aGame discardCardsDeskAmount)
		equals: 0.
]

{ #category : #tests }
CardsTest >> testV002VerifyThatOneCardHasNotBeenDiscardWhenItIsUsedBecauseItIsPermanent [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	self assert: aGame discardCardsDeskAmount equals: 0
]

{ #category : #tests }
CardsTest >> testV003VerifyThatTwoCardsHasNotBeenDiscardWhenAreUsedBecauseTheyArePermanent [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	aCard := OverloadCard new.
	aGame apply: aCard to: 'blue' from: 'red'.
	self assert: aGame discardCardsDeskAmount equals: 0
]

{ #category : #tests }
CardsTest >> testV005VerifyThatExistAFiniteAmountOfCardsToDeal [

	| aGame aDeck|
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	self assert: aGame cardsToDeal equals: 1
]

{ #category : #tests }
CardsTest >> testV006VerifyThatExistAFiniteAmountOfCardsToDealWhenTheyAreStolenFromARandomCardBox [

	| aGame aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: OverloadCard new amount: 6.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomCardBoxes)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	self assert: aGame cardsToDeal equals: 1
]

{ #category : #tests }
CardsTest >> testV007VerifyThatExistAFiniteAmountOfCardsToDealWhenTheyAreShuffle [

	| aGame aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomCardBoxes)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	self assert: aGame cardsToDeal equals: 0
]

{ #category : #tests }
CardsTest >> testV008VerifyThatExistAFiniteAmountOfCardsToDealAndTheyAreNotDealDespiteThePlayerIsInARandomCardBox [

	| aGame aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomCardBoxes)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.

	self assert: (aGame cardsInPosetionOf: 'red') equals: 3.
	self assert: (aGame cardsInPosetionOf: 'blue') equals: 2
]

{ #category : #tests }
CardsTest >> testV009VerifyThatWhenThereAreMoreThanOneCardAmountOfTheSameCardEverythingWorksCorrect [

	| aGame aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 3.
	aDeck addCard: SpeedCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomCardBoxes)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.

	self assert: (aGame cardsInPosetionOf: 'red') equals: 3.
	self assert: (aGame cardsInPosetionOf: 'blue') equals: 2
]

{ #category : #tests }
CardsTest >> testV010VerifyThatOneCardHasBeenDiscardWhenItIsUsed [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: RepeatCard new amount: 10.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoardWithRandomCardBoxes
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aCard := RepeatCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	self assert: aGame discardCardsDeskAmount equals: 1
]

{ #category : #tests }
CardsTest >> testW012VerifyTheAmountOfAveilableCardsAfterActivatingOne [

	| aGame aCard aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: SpeedCard new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	self assert: aGame discardCardsDeskAmount equals: 0
]

{ #category : #tests }
CardsTest >> testW013VerifyTheAmountOfDiscardCardsAfterDesactivatingOne [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: SpeedCard new amount: 2.
	aDeck addCard: CancellationCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	self assert: aGame discardCardsDeskAmount equals: 2
]

{ #category : #tests }
CardsTest >> testW014VerifyThatWhenARedoCardIsDiscardARedoCardGoToTheDiscardDeck [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: SpeedCard new amount: 1.
	aDeck addCard: RedoCard new amount: 1.
	aDeck addCard: CancellationCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoardWithRandomCardBoxes
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := RedoCard create.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: RedoCard create
		of: 'red'
		from: 'blue'.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := RedoCard create.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: RedoCard create
		of: 'red'
		from: 'blue'.
	self assert: aGame discardCardsDeskAmount equals: 4
]

{ #category : #tests }
CardsTest >> testW015VerifyTheCorrectDesactivationOfAnAccelerationCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: AccelerationCard new amount: 2.
	aDeck addCard: CancellationCard new amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: AccelerationCard new
		of: EveryPlayer new
		from: 'blue'.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testW018VerifyTheCorrectDiscardOfAnAccelerationAnTryingToReuseItThen [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: AccelerationCard new amount: 1.
	aDeck addCard: CancellationCard new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoardWithRandomCardBoxes
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: AccelerationCard new
		of: EveryPlayer new
		from: 'blue'.
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard new.
	aGame apply: aCard to: EveryPlayer new from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: AccelerationCard new
		of: EveryPlayer new
		from: 'blue'.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3).
	self assert: aGame discardCardsDeskAmount equals: 2
]

{ #category : #tests }
CardsTest >> testW019TryToDealEmptyObjects [

	| aGame aDeck |
	aDeck := CardsDeck create.
	aDeck addCard: EmptyObject new amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoardWithRandomCardBoxes
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	self assert: (aGame cardsInPosetionOf: 'red') equals: 0.
	self assert: (aGame cardsInPosetionOf: 'blue') equals: 0
]

{ #category : #tests }
CardsTest >> testW020VerifyThatWhenARedoCardIsDiscardARedoCardGoToTheDiscardDeckRedoingAnInstantCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck create.
	aDeck addCard: SpeedCard new amount: 2.
	aDeck addCard: CancellationCard new amount: 1.
	aDeck addCard: RedoCard new amount: 1.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoardWithRandomCardBoxes
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	aCard := RedoCard create.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := SpeedCard new.
	aGame apply: aCard to: 'red' from: 'red'.
	aCard := CancellationCard new.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	aCard := RedoCard create.
	aGame
		apply: aCard
		to: SpeedCard new
		of: 'red'
		from: 'blue'.
	self assert: aGame discardCardsDeskAmount equals: 4
]
