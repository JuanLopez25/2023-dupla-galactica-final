Class {
	#name : #MovePlayersInTurnFromTheGameTest,
	#superclass : #TestCase,
	#instVars : [
		'aColorCollection',
		'aLoadedDie',
		'aGame',
		'boxes',
		'aBoard',
		'aShaker'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
MovePlayersInTurnFromTheGameTest >> setUp [

	| aDeck |
	super setUp.
	aDeck := AveilableCardsDeck with: OverloadCard create amount: 3.
	aColorCollection := OrderedCollection with: 'red' with: 'blue'.
	aLoadedDie := LoadedDie with:
		              (OrderedCollection with: 1 with: 2 with: 3).
	boxes := (BoxCreator use:
		          (OrderedCollection with: (BoxProbability using: EmptyObject new withChance: 100))) 
		         create: 10.
	
	aShaker := DiceShaker withDie: aLoadedDie.
	aBoard := Board with: boxes measure: (Parsec worth: 100).
	aGame := DuplaGalacticaGameProxy
		         with: aColorCollection
		         and: aBoard
		         usingToThrow: aShaker
		         winningWhen: 1
		         using: (CardDealer with: aDeck)
]

{ #category : #tests }
MovePlayersInTurnFromTheGameTest >> testJ001CheckTheCurrentPlayerTurn [

	self assert: aGame currentPlayer equals: 'red'
]

{ #category : #tests }
MovePlayersInTurnFromTheGameTest >> testJ002CheckTheCurrentPlayerAfterMovingTheFirstOne [

	aGame movePlayer.
	self assert: aGame currentPlayer equals: 'blue'
]

{ #category : #tests }
MovePlayersInTurnFromTheGameTest >> testJ003CheckTheCurrentPlayerOnceAllThePlayersThrowOneTime [

	aGame movePlayer.
	aGame movePlayer.
	self assert: aGame currentPlayer equals: 'red'
]
