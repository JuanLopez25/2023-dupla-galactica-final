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
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testQ003VerifyTheCorrectUseOfOverloadCardWhenThePlayerHasToGoBackwardsDueToANegativeEffect [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
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

	| aGame aRedPosition aBluePosition aCard aDeck |
	aRedPosition := Position atTheBeginning.
	aBluePosition := Position atTheBeginning move: 2.
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersPositions
		equals: (OrderedCollection with: aRedPosition with: aBluePosition)
]

{ #category : #tests }
CardsTest >> testQ005VerifyTheCorrectUseOfASpeedCard [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : #tests }
CardsTest >> testQ006VerifyTheCorrectUseOfASpeedCardWhenThrowingMoreThanOneTime [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
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
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aLoadedShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersLaps
		equals: (OrderedCollection with: 1 with: 0)
]

{ #category : #tests }
CardsTest >> testQ008VerifyTheCorrectUseOfPermanentCardsWhenAPlayerHasMoreThanOneActive [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 3)
]

{ #category : #tests }
CardsTest >> testQ009VerifyTheCorrectUseOfAccelerationCard [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: AccelerationCard create amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testQ010VerifyTheCorrectUseOfAccelerationCardWhenHasToRaiseALap [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: AccelerationCard create amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
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
	aDeck := LoadedDeck with: OverloadCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         (OverloadCard create selectTarget: 'blue').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ012VerifyTheCorrectUseOfCancellationCardWhenThePlayerHasMoreThanOneCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: SpeedCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 1)
]

{ #category : #tests }
CardsTest >> testQ013VerifyTheCorrectUseOfTwoCancellationCards [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: SpeedCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ014TryToCancellAPermanentCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: CancellationCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard 
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
		         (OverloadCard create newHolder: 'red').
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'There are no active permanent cards'
]

{ #category : #tests }
CardsTest >> testQ015TryToCancellAPermanentCardWithATypeOfCardThatIsNotActivate [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: OverloadCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         (OverloadCard create newHolder: 'red').
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage:
		'There are no that type of cards activate in this player or is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ017TryToUseAnOverLoadCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'blue') selectTarget: 'red'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
]

{ #category : #tests }
CardsTest >> testQ018TryToUseASpeedCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ019TryToUseAnAccelerationCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard 
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (AccelerationCard create newHolder: 'red').

	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ020UseTwoOverLoadCardsFromTheSamePlayerToTheSamePlayer [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testQ021UseAnOverLoadCardAndThenTryToUseItAgainButItHasGoneAway [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ022UseTwoSpeedCardsFromTheSamePlayerToTheSamePlayer [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 3)
]

{ #category : #tests }
CardsTest >> testQ023UseASpeedCardAndThenTryToUseItAgainButItHasGoneAway [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ024UseTwoAccelerationCardsFromTheSamePlayer [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: AccelerationCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 5)
]

{ #category : #tests }
CardsTest >> testQ025UseAnAccelerationCardAnThenTryToUseItAgainButItHasGoneAway [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: AccelerationCard create amount: 6.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := AccelerationCard create newHolder: 'red'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ026TryToUseACancellationCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).

	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget: 'blue'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ026TryToUseACancellationCardWithANonValidObjective [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: OverloadCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget: 'blue'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage:
		'There are no that type of cards activate in this player or is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ027UseTwoCancellationCardsFromTheSamePlayer [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: OverloadCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 2
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         (OverloadCard create selectTarget: 'blue').
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         (OverloadCard create selectTarget: 'blue').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ029VerifyTheCorrectUseOfRedoCardWhenLastCardPlayIsAnOverloadCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: OverloadCard create amount: 2.
	aDeck addCard: RedoCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	aCard := (RedoCard create newHolder: 'blue') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testQ030VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsACancellationCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: SpeedCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 1.
	aDeck addCard: RedoCard  create amount: 1.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aCard := (RedoCard create newHolder: 'blue') selectTarget:
		         (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ031VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsASpeedCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: SpeedCard create amount: 2.
	aDeck addCard: RedoCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aCard := (RedoCard create newHolder: 'blue') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testQ032VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsAnAccelerationCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: AccelerationCard create amount: 2.
	aDeck addCard: RedoCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aCard := RedoCard create newHolder: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 5)
]

{ #category : #tests }
CardsTest >> testQ033VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsARedoCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: AccelerationCard create amount: 2.
	aDeck addCard: RedoCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aCard := RedoCard create newHolder: 'blue'.
	aGame apply: aCard.
	aCard := RedoCard create newHolder: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 6)
]

{ #category : #tests }
CardsTest >> testQ034VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsASpeedUpOne [

	| aGame aCard aDeck boxes aBoard |
	aDeck := AveilableCardsDeck with: RepeatCard create amount: 4.
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability using: SpeedUpBox new withChance: 100))) 
		         create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (RepeatCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 7)
]

{ #category : #tests }
CardsTest >> testQ035VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsAWormHoleOne [

	| aGame boxes aBoard aCard aDeck aDie aLoadedShaker |
	aDeck := AveilableCardsDeck with: RepeatCard create amount: 4.
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
	aCard := (RepeatCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 2)
]

{ #category : #tests }
CardsTest >> testQ036VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsAMoonWalkOne [

	| aGame aLoadedDie boxes aBoard aLoadedShaker aCard aDeck |
	aDeck := AveilableCardsDeck with: RepeatCard create amount: 4.
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
		         using:
		         (CardDealer with: aDeck).


	aGame movePlayer.
	aGame movePlayer.
	aCard := (RepeatCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testQ037VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsAnAtomicBombOne [

	| aGame boxes aBoard aCard aDeck |
	aDeck := AveilableCardsDeck with: RepeatCard create amount: 4.
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
	aCard := (RepeatCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.


	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
CardsTest >> testQ038VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsHyperJumpOne [

	| aGame boxes aBoard aCard aDeck |
	aDeck := AveilableCardsDeck with: RepeatCard create amount: 4.
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
	aCard := (RepeatCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.


	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 7)
]

{ #category : #tests }
CardsTest >> testQ039VerifyThatAccelerationCardCanOnlyBePlayedAtPlayersTurns [

	| aGame aDeck |
	aDeck := AveilableCardsDeck with: AccelerationCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	self
		should: [ aGame apply: (AccelerationCard create newHolder: 'red') ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
]

{ #category : #tests }
CardsTest >> testQ041VerifyThatSpeedCardCanOnlyBePlayedAtPlayersTurns [

	| aGame aCard aDeck |
	
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aGame movePlayer.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
]

{ #category : #tests }
CardsTest >> testQ042VerifyThatCancellationCardCanBePlayWheneverThePlayerWants [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: CancellationCard create amount: 2.
	aDeck addCard: AccelerationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aCard := AccelerationCard create newHolder: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
		         (AccelerationCard create selectTarget: 'blue').
	aGame apply: aCard.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ043VerifyThatRedoCardCanBePlayWheneverThePlayerWants [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: AccelerationCard create amount: 2.
	aDeck addCard: RedoCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := RedoCard create newHolder: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 1)
]

{ #category : #tests }
CardsTest >> testQ044VerifyThatRepeatCardCanBePlayWheneverThePlayerWants [

	| aGame boxes aBoard aCard aDeck |
	aDeck := AveilableCardsDeck with: RepeatCard create amount: 4.
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
	aCard := (RepeatCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 7)
]

{ #category : #tests }
CardsTest >> testQ045VerifyThatRedoCardCanRepeatTheEffectOfTheRepeatCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: RepeatCard create amount: 2.
	aDeck addCard: RedoCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomCardBoxes)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).

	aGame movePlayer.
	aCard := (RepeatCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (RedoCard create newHolder: 'blue') selectTarget: 'blue'.
	aGame apply: aCard.

	self assert: (aGame cardsInPosetionOf: 'red') equals: 1.
	self assert: (aGame cardsInPosetionOf: 'blue') equals: 2.
]

{ #category : #tests }
CardsTest >> testQ048VerifyThatWhenUsingAnOverloadCardTheObjectiveMustBeAValidPlayer [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget:
		         (AccelerationCard create newHolder: 'blue').
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'That is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ050VerifyThatWhenUsingASpeedCardTheObjectiveMustBeAValidPlayer [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget:  (AccelerationCard create newHolder: 'blue').
	self
		should: [ 
			aGame
				apply: aCard]
		raise: Error
		withMessage: 'That is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ051VerifyThatWhenUsingARepeatCardTheObjectiveMustBeAValidPlayer [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: RepeatCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (RepeatCard create newHolder: 'red') selectTarget: 'pepe'.
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'That is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ052VerifyThatWhenUsingARedoCardACardHasToBeenPlayedBefore [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: RedoCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (RedoCard create newHolder: 'red') selectTarget:  'pepe'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage:
		'Redo card cannot be played because there are no cards that have been played before'
]

{ #category : #tests }
CardsTest >> testV001VerifyThatNoCardsHasBeenDiscardAtTheBeggining [

	| aGame aDeck |
	aDeck := AveilableCardsDeck with: RedoCard create amount: 5.
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
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	self
		assert: (aGame discardCardsDeskAmount)
		equals: 0.
]

{ #category : #tests }
CardsTest >> testV003VerifyThatTwoCardsHasNotBeenDiscardWhenAreUsedBecauseTheyArePermanent [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	self assert: aGame discardCardsDeskAmount equals: 0
]

{ #category : #tests }
CardsTest >> testV005VerifyThatExistAFiniteAmountOfCardsToDeal [

	| aGame aDeck|
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 5.
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
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 6.
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
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 5.
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
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 5.
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
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 2.
	aDeck addCard: SpeedCard create amount: 3.
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
	aDeck := AveilableCardsDeck with: RepeatCard create amount: 10.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomCardBoxes)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aGame movePlayer.
	aCard := (RepeatCard  create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	self
		assert: (aGame discardCardsDeskAmount)
		equals: 1.
]

{ #category : #tests }
CardsTest >> testW001TryingToUseASpeedCardWithoutSettingAHolder [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard create) selectTarget: 'red'.
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The card does not have a holder'
]

{ #category : #tests }
CardsTest >> testW002TryingToUseAnOverloadCardWithoutSettingAHolder [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard create) selectTarget: 'red'.
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The card does not have a holder'
]

{ #category : #tests }
CardsTest >> testW003TryingToUseAnAccelerationCardWithoutSettingAHolder [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: AccelerationCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (AccelerationCard create).
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The card does not have a holder'
]

{ #category : #tests }
CardsTest >> testW004TryingToUseARepeatCardWithoutSettingAHolder [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: RepeatCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (RepeatCard create) selectTarget: 'red'.
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The card does not have a holder'
]

{ #category : #tests }
CardsTest >> testW005TryingToUseARedoCardWithoutSettingAHolder [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: RedoCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (RedoCard create) selectTarget: 'red'.
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The card does not have a holder'
]

{ #category : #tests }
CardsTest >> testW006TryingToUseACancellationCardWithoutSettingAHolder [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: CancellationCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (CancellationCard create) selectTarget: 'red'.
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The card does not have a holder'
]

{ #category : #tests }
CardsTest >> testW007TryingToUseASpeedCardWithoutSettingAnObjective [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red').
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The objective has not been specify'
]

{ #category : #tests }
CardsTest >> testW008TryingToUseAnOverloadCardWithoutSettingAnObjective [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard create newHolder: 'red').
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The objective has not been specify'
]

{ #category : #tests }
CardsTest >> testW009TryingToUseACancellationCardWithoutSettingAnObjective [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: CancellationCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (CancellationCard create newHolder: 'red').
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The objective has not been specify'
]

{ #category : #tests }
CardsTest >> testW010TryingToUseARedoCardWithoutSettingAnObjective [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: SpeedCard create amount: 2.
	aDeck addCard: RedoCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aCard := (RedoCard create newHolder: 'blue').
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The objective has not been specify'
]

{ #category : #tests }
CardsTest >> testW011TryingToUseARepeatCardWithoutSettingAnObjective [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: RepeatCard create amount: 5.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (RepeatCard create newHolder: 'red').
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The objective has not been specify'
]

{ #category : #tests }
CardsTest >> testW012VerifyTheAmountOfAveilableCardsAfterActivatingOne [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: SpeedCard create amount: 4.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	self assert: aGame discardCardsDeskAmount equals: 0
]

{ #category : #tests }
CardsTest >> testW013VerifyTheAmountOfDiscardCardsAfterDesactivatingOne [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: SpeedCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget: (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	self assert: aGame discardCardsDeskAmount equals: 2
]

{ #category : #tests }
CardsTest >> testW014VerifyThatWhenARedoCardIsDiscardARedoCardGoToTheDiscardDeck [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: SpeedCard create amount: 1.
	aDeck addCard: RedoCard create amount: 1.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomCardBoxes)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (RedoCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget: (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget: (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (RedoCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget: (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget: (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	self assert: aGame discardCardsDeskAmount equals: 4
]

{ #category : #tests }
CardsTest >> testW015VerifyTheCorrectDesactivationOfAnAccelerationCard [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: AccelerationCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         (AccelerationCard create selectTarget: 'red').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testW016VerifyTheCorrectDesactivationOfAnAccelerationCardSpecifyingOtherPlayerColors [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: AccelerationCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoard)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         (AccelerationCard create selectTarget: 'blue').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testW017VerifyTheCorrectDesactivationOfAnAccelerationWithoutSpecifyingTarget [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: AccelerationCard create amount: 2.
	aDeck addCard: CancellationCard create amount: 2.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: self createBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         AccelerationCard create.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testW018VerifyTheCorrectDiscardOfAnAccelerationAnTryingToReuseItThen [

	| aGame aCard aDeck |
	aDeck := LoadedDeck with: AccelerationCard create amount: 1.
	aDeck addCard: CancellationCard create amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomCardBoxes)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         AccelerationCard create.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'blue') selectTarget:
		         AccelerationCard create.
	aGame apply: aCard.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3).
	self assert: aGame discardCardsDeskAmount equals: 2.
]

{ #category : #tests }
CardsTest >> testW019TryToDealEmptyObjects [

	| aGame aDeck |
	aDeck := AveilableCardsDeck with: EmptyObject new amount: 3.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomCardBoxes)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	self
		assert: (aGame cardsInPosetionOf: 'red')
		equals: 0.
	self
		assert: (aGame cardsInPosetionOf: 'blue')
		equals: 0.
]
