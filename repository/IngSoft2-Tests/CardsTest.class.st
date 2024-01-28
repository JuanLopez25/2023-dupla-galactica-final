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
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability using: NoEffectBox new withChance: 100))) create: 10.
	^ aBoard := Board with: boxes measure: (Parsec worth: 100).
]

{ #category : #Creation }
CardsTest >> createBoardWithRandomBoxDealing: amountOfCards [

	| boxes |
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability
				            using: (RandomCardBox dealing: amountOfCards)
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard  amount: 3).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard amount: 3).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard amount: 3).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 3).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 3).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 3).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 3).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: AccelerationCard amount: 3).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: AccelerationCard amount: 3).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard amount: 3).
	aDeck addNewCards:
		(CardAmount usingType: CancellationCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 2)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
		         (OverloadCard create selectTarget: 'blue').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 4)
]

{ #category : #tests }
CardsTest >> testQ012VerifyTheCorrectUseOfCancellationCardWhenThePlayerHasMoreThanOneCard [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 4).
	aDeck addNewCards:
		(CardAmount usingType: CancellationCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 3)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
		         (SpeedCard create selectTarget: 'blue').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 5)
]

{ #category : #tests }
CardsTest >> testQ013VerifyTheCorrectUseOfTwoCancellationCards [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 4).
	aDeck addNewCards:
		(CardAmount usingType: CancellationCard amount: 4).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 4)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
		         (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
		         (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 4)
]

{ #category : #tests }
CardsTest >> testQ014TryToCancellAPermanentCardWhenThePlayerDoesNotHaveOne [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: CancellationCard amount: 4).
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
		withMessage: 'There are no permanent cards'
]

{ #category : #tests }
CardsTest >> testQ015TryToCancellAPermanentCardWithATypeOfCardThatIsNotActivate [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard amount: 3).
	aDeck addNewCards:
		(CardAmount usingType: CancellationCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 2)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard amount: 4).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard amount: 4).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: OverloadCard  amount: 4).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: OverloadCard  amount: 4).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard amount: 4).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 4).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 4).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: AccelerationCard amount: 4).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: AccelerationCard amount: 6).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard amount: 4).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard amount: 3).
	aDeck addNewCards:
		(CardAmount usingType: CancellationCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 2)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget: 'blue'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage:
		'There are no that type of cards activate in this player or is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ027UseTwoCancellationCardsFromTheSamePlayer [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: AccelerationCard amount: 4).
	aDeck addNewCards:
		(CardAmount usingType: CancellationCard amount: 4).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 4)
		         usingToThrow: aShaker
		         winningWhen: 2
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
		         (AccelerationCard create selectTarget: 'blue').
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
		         (AccelerationCard create selectTarget: 'blue').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 6 with: 4)
]

{ #category : #tests }
CardsTest >> testQ029VerifyTheCorrectUseOfRedoCardWhenLastCardPlayIsAnOverloadCard [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RedoCard amount: 3).
	aDeck addNewCards: (CardAmount usingType: OverloadCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 2)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (OverloadCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (RedoCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 2)
]

{ #category : #tests }
CardsTest >> testQ030VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsACancellationCard [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RedoCard amount: 3).
	aDeck addNewCards:
		(CardAmount usingType: CancellationCard amount: 3).
	aDeck addNewCards: (CardAmount usingType: SpeedCard amount: 4).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 6)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
		         (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aCard := (RedoCard create newHolder: 'red') selectTarget:
		         (SpeedCard create selectTarget: 'red').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 4)
]

{ #category : #tests }
CardsTest >> testQ031VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsASpeedCard [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RedoCard amount: 3).
	aDeck addNewCards:
		(CardAmount usingType: SpeedCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 2)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (RedoCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 5 with: 5)
]

{ #category : #tests }
CardsTest >> testQ032VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsAnAccelerationCard [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RedoCard amount: 3).
	aDeck addNewCards:
		(CardAmount usingType: AccelerationCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 2)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := RedoCard create newHolder: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 6 with: 6)
]

{ #category : #tests }
CardsTest >> testQ033VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsARedoCard [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RedoCard amount: 4).
	aDeck addNewCards:
		(CardAmount usingType: AccelerationCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 3)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := RedoCard create newHolder: 'red'.
	aGame apply: aCard.
	aCard := RedoCard create newHolder: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 7 with: 7)
]

{ #category : #tests }
CardsTest >> testQ034VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsASpeedUpOne [

	| aGame aCard aDeck boxes aBoard |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RepeatCard amount: 4).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RepeatCard amount: 4).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RepeatCard amount: 4).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RepeatCard amount: 4).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RepeatCard amount: 4).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: AccelerationCard amount: 4).
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
	aDeck:= AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 4).
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
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: CancellationCard amount: 3).
	aDeck addNewCards:
		(CardAmount usingType: AccelerationCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 2)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aCard := (CancellationCard create newHolder: 'red') selectTarget:
		         (AccelerationCard create selectTarget: 'blue').
	aGame apply: aCard.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 5 with: 4)
]

{ #category : #tests }
CardsTest >> testQ043VerifyThatRedoCardCanBePlayWheneverThePlayerWants [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RedoCard amount: 3).
	aDeck addNewCards:
		(CardAmount usingType: AccelerationCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 2)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard create newHolder: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aCard := RedoCard create newHolder: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 5 with: 6)
]

{ #category : #tests }
CardsTest >> testQ044VerifyThatRepeatCardCanBePlayWheneverThePlayerWants [

	| aGame boxes aBoard aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RepeatCard amount: 4).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RepeatCard amount: 3).
	aDeck addNewCards: (CardAmount usingType: RedoCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 2)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).

	aGame movePlayer.
	aCard := (RepeatCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (RedoCard create newHolder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.

	self assert: (aGame cardsInPosetionOf: 'red') equals: 2.
	self assert: (aGame cardsInPosetionOf: 'blue') equals: 4
]

{ #category : #tests }
CardsTest >> testQ048VerifyThatWhenUsingAnOverloadCardTheObjectiveMustBeAValidPlayer [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: OverloadCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RepeatCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RedoCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: OverloadCard amount: 5).
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
CardsTest >> testV002VerifyThatOneCardsHasBeenDiscardWhenItIsUsed [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: OverloadCard amount: 5).
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
		equals: 1.
]

{ #category : #tests }
CardsTest >> testV003VerifyThatTwoCardsHasBeenDiscardWhenAreUsed [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with:
		         (CardAmount usingType: OverloadCard amount: 5).
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
	self assert: aGame discardCardsDeskAmount equals: 2
]

{ #category : #tests }
CardsTest >> testV005VerifyThatExistAFiniteAmountOfCardsToDeal [

	| aGame aDeck|
	aDeck := AveilableCardsDeck with: (CardAmount usingType: OverloadCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: OverloadCard amount: 5).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 1)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	self assert: aGame cardsToDeal equals: 0
]

{ #category : #tests }
CardsTest >> testV007VerifyThatExistAFiniteAmountOfCardsToDealWhenTheyAreShuffle [

	| aGame aDeck aCard |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 5).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 1)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aCard := (SpeedCard create newHolder: 'blue') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (SpeedCard create newHolder: 'blue') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.

	self assert: aGame cardsToDeal equals: 3
]

{ #category : #tests }
CardsTest >> testV008VerifyThatExistAFiniteAmountOfCardsToDealAndTheyAreNotDealBesidesThePlayerIsInARandomCardBox [

	| aGame aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 5).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 1)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.

	self assert: (aGame cardsInPosetionOf: 'red') equals: 3.
	self assert: (aGame cardsInPosetionOf: 'blue') equals: 2
]

{ #category : #tests }
CardsTest >> testV009VerifyThatWhenMoreThanOneCardAmountOfTheSameCardEverythingWorksCorrect [

	| aGame aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 2).
	aDeck addNewCards: (CardAmount usingType: SpeedCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 1)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.

	self assert: (aGame cardsInPosetionOf: 'red') equals: 3.
	self assert: (aGame cardsInPosetionOf: 'blue') equals: 2
]

{ #category : #tests }
CardsTest >> testW001TryingToUseASpeedCardWithoutSettingAHolder [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: OverloadCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: AccelerationCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RepeatCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RedoCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: CancellationCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: SpeedCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: OverloadCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: CancellationCard amount: 5).
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
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RedoCard amount: 3).
	aDeck addNewCards: (CardAmount usingType: SpeedCard amount: 3).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: (self createBoardWithRandomBoxDealing: 2)
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (SpeedCard create newHolder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (RedoCard create newHolder: 'red').
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'The objective has not been specify'
]

{ #category : #tests }
CardsTest >> testW011TryingToUseARepeatCardWithoutSettingAnObjective [

	| aGame aCard aDeck |
	aDeck := AveilableCardsDeck with: (CardAmount usingType: RepeatCard amount: 5).
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
