Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#instVars : [
		'aColorCollection'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #Game }
CardsTest >> createBoard [

	| boxes aBoard |
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability using: NoEffectBox new withChance: 100))) create: 10.
	^ aBoard := Board with: boxes measure: (Parsec worth: 100).
]

{ #category : #running }
CardsTest >> setUp [

	super setUp.

	aColorCollection := OrderedCollection with: 'red' with: 'blue'.
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

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: OverloadCard  withChance: 3).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testQ002VerifyTheCorrectUseOfOverloadCardWhenThrowingMoreThanOneTime [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: OverloadCard  withChance: 3).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 5 with: 3)
]

{ #category : #tests }
CardsTest >> testQ003VerifyTheCorrectUseOfOverloadCardWhenThePlayerHasToGoBackwardsDueToANegativeEffect [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: OverloadCard  withChance: 3).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 5
			               with: 3
			               with: 0).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		        (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 5 with: 2)
]

{ #category : #tests }
CardsTest >> testQ004VerifyTheCorrectUseOfOverloadCardWhenThePlayerHasToGoBackwardsInTheFirstLapDueToANegativeEffect [

	| aGame aLoadedDie aBoard aRedPosition aBluePosition aShaker aCard aDeck |
	aRedPosition := (Position atTheBeginning) move: 1.
	aBluePosition := (Position atTheBeginning).
	aDeck := Deck with:
		         (CardProbability using: OverloadCard  withChance: 3).
	aBoard := self createBoard.
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 0
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersPositions 
		equals: (OrderedCollection with: aRedPosition with: aBluePosition)
	
]

{ #category : #tests }
CardsTest >> testQ005VerifyTheCorrectUseOfASpeedCard [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: SpeedCard  withChance: 3).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 4
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 5)
]

{ #category : #tests }
CardsTest >> testQ006VerifyTheCorrectUseOfASpeedCardWhenThrowingMoreThanOneTime [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: SpeedCard withChance: 3).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 5).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		        ((CardDealer with: aDeck)).
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 7 with: 8)
]

{ #category : #tests }
CardsTest >> testQ007VerifyTheCorrectUseOfASpeedCardWhenHasToRaiseALap [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: SpeedCard  withChance: 3).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 9
			               with: 2
			               with: 3
			               with: 5).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	self
		assert: aGame playersLaps
		equals: (OrderedCollection with: 1 with: 0)
]

{ #category : #tests }
CardsTest >> testQ008VerifyTheCorrectUseOfPermanentCardsWhenAPlayerHasMoreThanOneActive [

	| aGame aLoadedDie aBoard aShaker aCard aSecondCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: OverloadCard  withChance: 3).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 5
			               with: 2
			               with: 3
			               with: 5).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aSecondCard := (OverloadCard holder: 'red') selectTarget: 'red'.
	aGame apply: aSecondCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 3)
]

{ #category : #tests }
CardsTest >> testQ009VerifyTheCorrectUseOfAccelerationCard [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: AccelerationCard withChance: 3).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (AccelerationCard holder: 'red').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testQ010VerifyTheCorrectUseOfAccelerationCardWhenHasToRaiseALap [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: AccelerationCard withChance: 3).

	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 8
			               with: 9
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 1)
]

{ #category : #tests }
CardsTest >> testQ011VerifyTheCorrectUseOfCancellationCard [

	| aGame aLoadedDie aBoard boxes aShaker aCard aSecondCard aDeck |
	aDeck := Deck with:
		         (CardProbability using: OverloadCard withChance: 3).
	aDeck addCard:
		(CardProbability using: CancellationCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (RandomCardBox dealing: 2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 1
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.

	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	aSecondCard := (CancellationCard holder: 'red') selectTarget:
		               (OverloadCard holder: 'blue').
	aGame apply: aSecondCard.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 2)
]

{ #category : #tests }
CardsTest >> testQ012VerifyTheCorrectUseOfCancellationCardWhenThePlayerHasMoreThanOneCard [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: SpeedCard withChance: 3).
	aDeck addCard:
		(CardProbability using: CancellationCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability
				            using:
					            (RandomCardBox dealing: 2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 1
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (SpeedCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (SpeedCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard holder: 'red') selectTarget:
		         (SpeedCard holder: 'blue').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testQ013VerifyTheCorrectUseOfTwoCancellationCards [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: SpeedCard withChance: 3).
	aDeck addCard:
		(CardProbability using: CancellationCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (RandomCardBox dealing: 2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 1
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.

	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.

	aGame movePlayer.
	aCard := (SpeedCard holder: 'blue') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard holder: 'red') selectTarget:
		         (SpeedCard holder: 'blue').
	aGame apply: aCard.
	aGame movePlayer.

	aGame movePlayer.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 8 with: 5)
]

{ #category : #tests }
CardsTest >> testQ014TryToCancellAPermanentCardWhenThePlayerDoesNotHaveOne [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: CancellationCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (CancellationCard holder: 'red') selectTarget:
		         (OverloadCard holder: 'red').
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'There are no permanent cards'
]

{ #category : #tests }
CardsTest >> testQ015TryToCancellAPermanentCardWithATypeOfCardThatIsNotActivate [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with:
		         (CardProbability using: OverloadCard withChance: 3).
	aDeck addCard:
		(CardProbability using: CancellationCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (RandomCardBox dealing: 2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard holder: 'red') selectTarget:
		         (OverloadCard holder: 'red').
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage:
		'There are no that type of cards activate in this player or is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ017TryToUseAnOverLoadCardWhenThePlayerDoesNotHaveOne [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: OverloadCard  withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'blue') selectTarget: 'red'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
]

{ #category : #tests }
CardsTest >> testQ018TryToUseASpeedCardWhenThePlayerDoesNotHaveOne [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: OverloadCard  withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ019TryToUseAnAccelerationCardWhenThePlayerDoesNotHaveOne [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: OverloadCard  withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (AccelerationCard holder: 'red').

	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ020UseTwoOverLoadCardsFromTheSamePlayerToTheSamePlayer [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: OverloadCard  withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 4
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 2 with: 1)
]

{ #category : #tests }
CardsTest >> testQ021UseAnOverLoadCardAndThenTryToUseItAgainButItHasGoneAway [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: OverloadCard  withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 5
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	self
		should: [ 
			aGame
				apply: aCard]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ022UseTwoSpeedCardsFromTheSamePlayerToTheSamePlayer [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: SpeedCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 4
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 5)
]

{ #category : #tests }
CardsTest >> testQ023UseASpeedCardAndThenTryToUseItAgainButItHasGoneAway [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: SpeedCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 4
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ024UseTwoAccelerationCardsFromTheSamePlayer [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.

	aDeck := Deck with:
		         (CardProbability using: AccelerationCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 4
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 7)
]

{ #category : #tests }
CardsTest >> testQ025UseAnAccelerationCardAnThenTryToUseItAgainButItHasGoneAway [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: AccelerationCard withChance: 6).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 4
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.
	aCard := AccelerationCard holder: 'red'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ026TryToUseACancellationCardWhenThePlayerDoesNotHaveOne [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: OverloadCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).

	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard holder: 'red') selectTarget: 'blue'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'The player does not have that card in posetion'
]

{ #category : #tests }
CardsTest >> testQ026TryToUseACancellationCardWithANonValidObjective [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with:
		         (CardProbability using: OverloadCard withChance: 3).
	aDeck addCard:
		(CardProbability using: CancellationCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (RandomCardBox dealing: 2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (CancellationCard holder: 'red') selectTarget: 'blue'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage:
		'There are no that type of cards activate in this player or is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ027UseTwoCancellationCardsFromTheSamePlayer [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with:
		         (CardProbability using: AccelerationCard withChance: 4).
	aDeck addCard:
		(CardProbability using: CancellationCard withChance: 4).
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (RandomCardBox dealing: 4)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).

	aLoadedDie := LoadedDie with:
		              (OrderedCollection with: 1 with: 1 with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 2
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard holder: 'red') selectTarget:
		         (AccelerationCard holder: 'blue').
	aGame apply: aCard.
	aCard := (CancellationCard holder: 'red') selectTarget:
		         (AccelerationCard holder: 'blue').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 5 with: 3)
]

{ #category : #tests }
CardsTest >> testQ029VerifyTheCorrectUseOfRedoCardWhenLastCardPlayIsAnOverloadCard [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RedoCard withChance: 3).
	aDeck addCard: (CardProbability using: OverloadCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (RandomCardBox dealing: 2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 4
			               with: 4
			               with: 1
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (RedoCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 4)
]

{ #category : #tests }
CardsTest >> testQ030VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsACancellationCard [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RedoCard withChance: 3).
	aDeck addCard:
		(CardProbability using: CancellationCard withChance: 3).
	aDeck addCard: (CardProbability using: SpeedCard withChance: 4).
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (RandomCardBox dealing: 6)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 1
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard holder: 'red') selectTarget:
		         (SpeedCard holder: 'red').
	aGame apply: aCard.
	aCard := (RedoCard holder: 'red') selectTarget:
		         (SpeedCard holder: 'red').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 3)
]

{ #category : #tests }
CardsTest >> testQ031VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsASpeedCard [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RedoCard withChance: 4).
	aDeck addCard:
		(CardProbability using: SpeedCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability
				            using:
					            (RandomCardBox dealing: 2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 1
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (RedoCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 4)
]

{ #category : #tests }
CardsTest >> testQ032VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsAnAccelerationCard [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RedoCard withChance: 4).
	aDeck addCard:
		(CardProbability using: AccelerationCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability
				            using:
					            (RandomCardBox dealing: 2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).

	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 1
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.
	aCard := RedoCard holder: 'red'.
	aGame apply: aCard.

	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 5 with: 5)
]

{ #category : #tests }
CardsTest >> testQ033VerifyTheCorrectUseOfRedoCardWhenLastCardPlayedIsARedoCard [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RedoCard withChance: 4).
	aDeck addCard:
		(CardProbability using: AccelerationCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (RandomCardBox dealing: 3)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 1
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.
	aCard := RedoCard holder: 'red'.
	aGame apply: aCard.
	aCard := RedoCard holder: 'red'.
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 6 with: 6)
]

{ #category : #tests }
CardsTest >> testQ034VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsASpeedUpOne [

	| aGame aLoadedDie boxes aBoard aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RepeatCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
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
	aCard := (RepeatCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 6)
]

{ #category : #tests }
CardsTest >> testQ035VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsAWormHoleOne [

	| aGame aLoadedDie boxes aBoard aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RepeatCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 4
			               with: 9
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability using: WormHoleBox new withChance: 100))) 
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
	aCard := (RepeatCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 2)
]

{ #category : #tests }
CardsTest >> testQ036VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsAMoonWalkOne [

	| aGame aLoadedDie boxes aBoard aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RepeatCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 4
			               with: 5
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (MoonWalkBox with: -2)
				            withChance: 100))) create: 10.
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
	aCard := (RepeatCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 3 with: 4)
]

{ #category : #tests }
CardsTest >> testQ037VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsAnAtomicBombOne [

	| aGame aLoadedDie boxes aBoard aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RepeatCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 4
			               with: 5
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
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
	aCard := (RepeatCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.


	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 1 with: 1)
]

{ #category : #tests }
CardsTest >> testQ038VerifyTheCorrectUseOfRepeatCardWhenLastBoxIsHyperJumpOne [

	| aGame aLoadedDie boxes aBoard aShaker aCard aDeck |
	aDeck:= Deck with: (CardProbability using: RepeatCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 5
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
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
		         using:
		         (CardDealer with: aDeck).


	aGame movePlayer.
	aGame movePlayer.
	aCard := (RepeatCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.


	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 10)
]

{ #category : #tests }
CardsTest >> testQ039VerifyThatAccelerationCardCanOnlyBePlayedAtPlayersTurns [

	| aGame aLoadedDie aBoard aShaker aDeck |
	aBoard := self createBoard.
	aDeck := Deck with:
		         (CardProbability using: AccelerationCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 4
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	self
		should: [ aGame apply: (AccelerationCard holder: 'red') ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
]

{ #category : #tests }
CardsTest >> testQ041VerifyThatSpeedCardCanOnlyBePlayedAtPlayersTurns [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck:= Deck with: (CardProbability using: SpeedCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 4
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aGame movePlayer.
	aCard := (SpeedCard holder: 'red') selectTarget: 'red'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'A permanent card can only be use when it is your turn'
]

{ #category : #tests }
CardsTest >> testQ042VerifyThatCancellationCardCanBePlayWheneverThePlayerWants [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: CancellationCard withChance: 3).
	aDeck addCard: (CardProbability using: AccelerationCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability
				            using:
					            (RandomCardBox dealing: 2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).

	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 1
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with:
			          aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.
	aCard := (CancellationCard holder: 'red') selectTarget:
		         (AccelerationCard holder: 'blue').
	aGame apply: aCard.
	aGame movePlayer.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 4 with: 3)
]

{ #category : #tests }
CardsTest >> testQ043VerifyThatRedoCardCanBePlayWheneverThePlayerWants [

	| aGame aLoadedDie aBoard boxes aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RedoCard withChance: 3).
	aDeck addCard:
		(CardProbability using: AccelerationCard withChance: 3).
	boxes := (BoxCreator use: (OrderedCollection with: (BoxProbability
				            using:
					            (RandomCardBox dealing: 2)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 1
			               with: 1).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	aGame movePlayer.
	aGame movePlayer.
	aCard := AccelerationCard holder: 'red'.
	aGame apply: aCard.
	aCard := RedoCard holder: 'red'.
	aGame apply: aCard.
	
	aGame movePlayer.
	aGame movePlayer.
	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 5 with: 5)
]

{ #category : #tests }
CardsTest >> testQ044VerifyThatRepeatCardCanBePlayWheneverThePlayerWants [

	| aGame aLoadedDie boxes aBoard aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RepeatCard withChance: 4).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
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
	aCard := (RepeatCard holder: 'red') selectTarget:  'red'.
	aGame apply: aCard.
	aGame movePlayer.

	self
		assert: aGame playersBox
		equals: (OrderedCollection with: 10 with: 6)
]

{ #category : #tests }
CardsTest >> testQ045VerifyThatRedoCardCanRepeatTheEffectOfTheRepeatCard [

	| aGame aLoadedDie boxes aBoard aShaker aCard aDeck |
	aDeck := Deck with: (CardProbability using: RepeatCard withChance: 3).
	aDeck addCard: (CardProbability using: RedoCard withChance: 3).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 1
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	boxes := (BoxCreator use: (OrderedCollection with:
			           (BoxProbability
				            using: (RandomCardBox dealing: 1)
				            withChance: 100))) create: 10.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).

	aGame movePlayer.
	aCard := (RepeatCard holder: 'red') selectTarget: 'red'.
	aGame apply: aCard.
	aCard := (RedoCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aGame movePlayer.

	self assert: (aGame cardsInPosetionOf: 'red') equals: 2.
	self assert: (aGame cardsInPosetionOf: 'blue') equals: 4
]

{ #category : #tests }
CardsTest >> testQ048VerifyThatWhenUsingAnOverloadCardTheObjectiveMustBeAValidPlayer [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: OverloadCard withChance: 5).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'red') selectTarget:
		         (AccelerationCard holder: 'blue').
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage: 'That is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ050VerifyThatWhenUsingASpeedCardTheObjectiveMustBeAValidPlayer [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: SpeedCard withChance: 5).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (SpeedCard holder: 'red') selectTarget:  (AccelerationCard holder: 'blue').
	self
		should: [ 
			aGame
				apply: aCard]
		raise: Error
		withMessage: 'That is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ051VerifyThatWhenUsingARepeatCardTheObjectiveMustBeAValidPlayer [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: RepeatCard withChance: 5).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (RepeatCard holder: 'red') selectTarget: 'pepe'.
	self
		should: [ 
		aGame apply:aCard ]
		raise: Error
		withMessage: 'That is not a valid objective'
]

{ #category : #tests }
CardsTest >> testQ052VerifyThatWhenUsingARedoCardACardHasToBeenPlayedBefore [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: RedoCard withChance: 5).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (RedoCard holder: 'red') selectTarget:  'pepe'.
	self
		should: [ aGame apply: aCard ]
		raise: Error
		withMessage:
		'Redo card cannot be played because there are no cards that have been played before'
]

{ #category : #tests }
CardsTest >> testV001VerifyThatNoCardsHasBeenDiscardAtTheBeggining [

	| aGame aLoadedDie aBoard aShaker aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: OverloadCard withChance: 5).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
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

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: OverloadCard withChance: 5).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	self
		assert: (aGame discardCardsDeskAmount)
		equals: 1.
]

{ #category : #tests }
CardsTest >> testV003VerifyThatTwoCardsHasBeenDiscardWhenAreUsed [

	| aGame aLoadedDie aBoard aShaker aCard aDeck |
	aBoard := self createBoard.
	aDeck := Deck with: (CardProbability using: OverloadCard withChance: 5).
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using:
		         (CardDealer with: aDeck).
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	aCard := (OverloadCard holder: 'red') selectTarget: 'blue'.
	aGame apply: aCard.
	self
		assert: (aGame discardCardsDeskAmount)
		equals: 2.
]

{ #category : #tests }
CardsTest >> testV005VerifyThatExistAFiniteAmountOfCardsToDeal [

	| aGame aLoadedDie aBoard aShaker aDeck |
	aBoard := self createBoard.
	aLoadedDie := LoadedDie with: (OrderedCollection
			               with: 1
			               with: 2
			               with: 3
			               with: 4).
	aShaker := DiceShaker withDie: aLoadedDie.
	aDeck := Deck with: (CardProbability using: OverloadCard withChance: 5).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck).
	self assert: aGame cardsToDeal equals: 1
]
